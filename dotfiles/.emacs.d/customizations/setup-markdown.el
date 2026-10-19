;; Markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(setq markdown-command "pandoc -f gfm -t html")
(setq markdown-preview-auto-open 'http)
(with-eval-after-load 'markdown-preview-mode
  (setq markdown-preview-stylesheets
        (list (concat "data:text/css;base64,"
                      (base64-encode-string
                       (encode-coding-string
                        (with-temp-buffer
                          (insert-file-contents (expand-file-name "~/.emacs.d/zenburn-preview.css"))
                          (buffer-string))
                        'utf-8)
                       t))))

  ;; Support multiple independent browser tabs (one per markdown buffer):
  ;; 1. Serve preview HTML dynamically in memory per ?uuid= (never overwrite a shared .markdown-preview.html file).
  ;; 2. Route WebSocket updates directly by preview-uuid instead of bouncing UUID-less HTML through a loopback client.
  ;; 3. Isolate idle timers and hooks per buffer.

  (make-variable-buffer-local 'markdown-preview--idle-timer)

  (defun markdown-preview--render-html (preview-uuid)
    "Render the preview HTML template in memory for PREVIEW-UUID."
    (let* ((md-buf (gethash preview-uuid markdown-preview--preview-buffers))
           (buf-obj (and md-buf (get-buffer md-buf)))
           (title (if buf-obj
                      (format "%s — Markdown preview" (buffer-name buf-obj))
                    "Markdown preview")))
      (with-temp-buffer
        (insert-file-contents markdown-preview--preview-template)
        (goto-char (point-min))
        (when (search-forward "<title>Markdown preview</title>" nil t)
          (replace-match (format "<title>%s</title>" (url-insert-entities-in-string title)) t t))
        (goto-char (point-min))
        (when (search-forward "${MD_STYLE}" nil t)
          (replace-match (markdown-preview--css) t t))
        (goto-char (point-min))
        (when (search-forward "${MD_JS}" nil t)
          (replace-match (markdown-preview--scripts) t t))
        (goto-char (point-min))
        (when (search-forward "${MD_JS_ONINIT}" nil t)
          (replace-match markdown-preview-script-oninit t t))
        (goto-char (point-min))
        (when (search-forward "${WS_HOST}" nil t)
          (replace-match markdown-preview-host t t))
        (goto-char (point-min))
        (when (search-forward "${WS_PORT}" nil t)
          (replace-match (format "%s" markdown-preview-ws-port) t t))
        (goto-char (point-min))
        (when (search-forward "${MD_UUID}" nil t)
          (replace-match (format "%s" preview-uuid) t t))
        (goto-char (point-min))
        (when (search-forward "${MD_JS_ONUPDATE}" nil t)
          (replace-match markdown-preview-script-onupdate t t))
        (buffer-string))))

  (defun markdown-preview--resolve-asset (path headers)
    "Resolve relative asset PATH against the requesting preview buffer's directory."
    (let ((referer (cdr (assoc :REFERER headers)))
          (found nil))
      (when (and referer (string-match "[?&]uuid=\\([^&#]+\\)" referer))
        (let* ((uuid (match-string 1 referer))
               (buf (gethash uuid markdown-preview--preview-buffers)))
          (when (and buf (get-buffer buf))
            (let ((candidate (expand-file-name path (buffer-local-value 'default-directory (get-buffer buf)))))
              (when (and (not (file-directory-p candidate)) (file-exists-p candidate))
                (setq found candidate))))))
      (unless found
        (maphash (lambda (_uuid buf)
                   (when (and (not found) buf (get-buffer buf))
                     (let ((candidate (expand-file-name path (buffer-local-value 'default-directory (get-buffer buf)))))
                       (when (and (not (file-directory-p candidate)) (file-exists-p candidate))
                         (setq found candidate)))))
                 markdown-preview--preview-buffers))
      found))

  (defun markdown-preview--http-handler (request)
    "Handle HTTP requests for `markdown-preview-mode' without disk file collisions."
    (with-slots (process headers) request
      (let ((path (substring (cdr (assoc :GET headers)) 1)))
        (cond
         ((string= path "")
          (let* ((uuid (markdown-preview--parse-uuid headers))
                 (md-buf (and uuid (gethash uuid markdown-preview--preview-buffers))))
            (if (and md-buf (get-buffer md-buf))
                (let ((body (encode-coding-string (markdown-preview--render-html uuid) 'utf-8)))
                  (ws-response-header process 200
                                      '("Content-Type" . "text/html; charset=utf-8")
                                      '("Cache-Control" . "no-store")
                                      (cons "Content-Length" (number-to-string (string-bytes body))))
                  (process-send-string process body))
              (ws-send-404 process))))
         ((string= path "favicon.ico")
          (ws-send-file process (expand-file-name path markdown-preview--home-dir)))
         (t
          (let ((filename (markdown-preview--resolve-asset path headers)))
            (if filename
                (ws-send-file process filename)
              (ws-send-404 process))))))))

  (defun markdown-preview--start-http-server (_port)
    "Start http server at `markdown-preview-http-port' to serve previews dynamically."
    (unless markdown-preview--http-server
      (advice-add 'make-network-process :filter-args #'markdown-preview--fix-network-process-wait)
      (setq markdown-preview--http-server
            (ws-start #'markdown-preview--http-handler
                      markdown-preview-http-port nil :host markdown-preview-http-host))
      (advice-remove 'make-network-process #'markdown-preview--fix-network-process-wait)))

  (defun markdown-preview--ws-on-message (websocket frame)
    "Handle incoming WebSocket messages from preview tabs."
    (let ((ws-frame-text (websocket-frame-payload frame)))
      (when (and (stringp ws-frame-text)
                 (string-prefix-p "MDPM-Register-UUID: " ws-frame-text))
        (let ((ws-uuid (substring ws-frame-text 20)))
          (puthash ws-uuid websocket markdown-preview--remote-clients)
          (markdown-preview--send-preview-to websocket ws-uuid)))))

  (defun markdown-preview--start-websocket-server ()
    "Start `markdown-preview' websocket server."
    (when (not markdown-preview--websocket-server)
      (setq markdown-preview--websocket-server
            (websocket-server
             markdown-preview-ws-port
             :host markdown-preview-host
             :on-message #'markdown-preview--ws-on-message
             :on-open (lambda (_websocket) (message "Websocket opened"))
             :on-error (lambda (_websocket _type err) (message (format "====> Error: %s" err)))
             :on-close (lambda (_websocket) (markdown-preview--drop-closed-clients))))
      (add-hook 'kill-emacs-hook 'markdown-preview--stop-websocket-server))
    (markdown-preview--open-browser-preview))

  (defun markdown-preview--send-preview (preview-uuid)
    "Send the `markdown-preview' with PREVIEW-UUID directly to its remote client."
    (when (bound-and-true-p markdown-preview-mode)
      (let ((ws (gethash preview-uuid markdown-preview--remote-clients)))
        (when (and ws (websocket-openp ws))
          (markdown-preview--send-preview-to ws preview-uuid)))))

  (defun markdown-preview--send-preview-to (websocket preview-uuid)
    "Send the `markdown-preview' with PREVIEW-UUID to a specific WEBSOCKET."
    (let* ((md-buf-name (gethash preview-uuid markdown-preview--preview-buffers))
           (md-buffer (and md-buf-name (get-buffer md-buf-name))))
      (when (and md-buffer (buffer-live-p md-buffer)
                 websocket (websocket-openp websocket))
        (let ((mark-position-percent "0")
              (rendered-html ""))
          (with-current-buffer md-buffer
            (let* ((win (get-buffer-window md-buffer t))
                   (screen-offset (if win
                                      (/ (count-screen-lines (window-start win) (point)) 2)
                                    0))
                   (total-lines (max 1 (count-lines (point-min) (point-max))))
                   (pct (truncate
                         (* 100
                            (/ (float (- (line-number-at-pos) screen-offset))
                               total-lines)))))
              (setq mark-position-percent (number-to-string (max 0 (min 100 pct)))))
            (let ((mark-active nil))
              (markdown markdown-output-buffer-name)))
          (with-current-buffer markdown-output-buffer-name
            (setq rendered-html (buffer-substring-no-properties (point-min) (point-max))))
          (websocket-send-text
           websocket
           (concat
            "<div>"
            "<span id='position-percentage'>"
            mark-position-percent
            "</span>"
            "<div id='content'>"
            rendered-html
            "</div>"
            "</div>"))))))

  (defun markdown-preview--on-after-save ()
    "Update preview for the saved buffer."
    (when (and (bound-and-true-p markdown-preview-mode)
               markdown-preview--uuid)
      (markdown-preview--send-preview markdown-preview--uuid)))

  (defun markdown-preview--start ()
    "Start `markdown-preview' mode in current buffer."
    (unless markdown-preview--uuid
      (setq-local markdown-preview--uuid (markdown-preview--random-uuid)))
    (puthash markdown-preview--uuid (buffer-name) markdown-preview--preview-buffers)
    (when (eq markdown-preview-auto-open 'file)
      (markdown-preview--read-preview-template
       markdown-preview--uuid
       (expand-file-name markdown-preview-file-name default-directory)))
    (markdown-preview--start-http-server markdown-preview-http-port)
    (markdown-preview--start-websocket-server)
    (markdown-preview--stop-idle-timer)
    (let ((buf (current-buffer)))
      (setq-local markdown-preview--idle-timer
                  (run-with-idle-timer
                   markdown-preview-delay-time t
                   (lambda ()
                     (when (and (buffer-live-p buf)
                                (eq (current-buffer) buf))
                       (with-current-buffer buf
                         (when (and (bound-and-true-p markdown-preview-mode)
                                    markdown-preview--uuid)
                           (markdown-preview--send-preview markdown-preview--uuid))))))))
    (add-hook 'after-save-hook #'markdown-preview--on-after-save nil t)
    (add-hook 'kill-buffer-hook #'markdown-preview--stop nil t))

  (defun markdown-preview--stop ()
    "Stop `markdown-preview' mode in current buffer."
    (remove-hook 'after-save-hook #'markdown-preview--on-after-save t)
    (remove-hook 'kill-buffer-hook #'markdown-preview--stop t)
    (markdown-preview--stop-idle-timer)
    (when markdown-preview--uuid
      (remhash markdown-preview--uuid markdown-preview--preview-buffers))
    (when (eq markdown-preview-auto-open 'file)
      (let* ((preview-file-dir (if (buffer-file-name)
                                   (file-name-directory (buffer-file-name))
                                 default-directory))
             (preview-file (concat preview-file-dir markdown-preview-file-name)))
        (when (file-exists-p preview-file)
          (delete-file preview-file)))))

  ;; Hot-patch running servers if setup-markdown.el is reloaded in a live session
  (when markdown-preview--http-server
    (setf (ws-handlers markdown-preview--http-server) #'markdown-preview--http-handler))
  (when markdown-preview--websocket-server
    (process-put markdown-preview--websocket-server :on-message #'markdown-preview--ws-on-message)
    (dolist (ws websocket-server-websockets)
      (when (eq (websocket-server-conn ws) markdown-preview--websocket-server)
        (setf (websocket-on-message ws) #'markdown-preview--ws-on-message)))))

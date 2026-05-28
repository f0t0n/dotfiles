;; Markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(setq markdown-command "pandoc")
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
                       t)))))

;;;; Setting up Emacs for Common Lisp programming
;;; customizations/common-lisp.el --- Common Lisp setup with SLY

;; 1. Ensure SLY is installed and configured
(use-package sly
  :ensure t
  :init
  ;; Tell SLY where the Lisp executable is (I use SBCL)
  (setq inferior-lisp-program "sbcl")
  :config
  ;; Enable modern "flex" completions (fuzzy matching)
  (setq sly-complete-symbol-function 'sly-flex-completions)
  ;; Ensure the REPL buffer remains clean and responsive
  (setq sly-mrepl-pop-slybuffer-back t))

;; 2. REPL Shortcut Strategy
;; Instead of fighting Paredit for the RET key, we let Paredit handle it
;; for structural indentation and assign C-RET as the "Force Execute" key.
(defun my-sly-mrepl-setup ()
  "Configure SLY REPL with Paredit and dedicated execution shortcut."
  (rainbow-delimiters-mode +1)
  (enable-paredit-mode)
  ;; Assign Control+Enter to evaluate the expression immediately.
  ;; This bypasses any Paredit structural 'safety' checks.
  (local-set-key (kbd "<C-return>") 'sly-mrepl-return))

;; 3. Hooks and Structural Editing
(add-hook 'sly-mrepl-mode-hook #'my-sly-mrepl-setup)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)

;; Automatically load paredit for all Lisp-family languages
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)

;; 4. Documentation and Feedback (ElDoc)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(provide 'common-lisp)

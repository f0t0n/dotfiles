;; TypeScript
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))
(add-hook 'typescript-mode-hook 'subword-mode)
(setq typescript-indent-level 2)

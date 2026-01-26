;; These customizations change the way emacs looks and disable/enable
;; some user interface elements. Some useful customizations are
;; commented out, and begin with the line "CUSTOMIZE". These are more
;; a matter of preference and may require some fiddling to match your
;; preferences

;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)


;; Show line numbers
;;(global-linum-mode t)


;; Show line numbers
;; https://stackoverflow.com/questions/76901942/getting-an-error-when-starting-up-emacs-related-to-global-linum-mode
(global-display-line-numbers-mode t) ;; Enable line numbers globally

;; Enable hybrid line numbers
(setq display-line-numbers-type 'relative)

;; Highlight current line number
(set-face-attribute 'line-number-current-line nil
                    :inherit 'line-number      ;; Keep basic font settings
                    :foreground "gold"         ;; Pick a bright color (e.g., "gold", "orange", or "#00ff00")
                    :weight 'bold              ;; Make it bold
                    :background "#333333"      ;; Give it a subtle background "block"
                    :height 1.0)              ;; To make it 10% larger than other numbers set height to 1.1x




;; 80 characters ruler:
(setopt global-display-fill-column-indicator-mode t)
(setq-default display-fill-column-indicator-column 100)

;; Rainbow delimeters (rainbow-deliemeters) mode settings:

;; Enable rainbow-delimiters for all programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Make the first level of parentheses stand out
;;(set-face-foreground 'rainbow-delimiters-depth-1-face "white")
;;(set-face-bold 'rainbow-delimiters-depth-1-face t)

;; Enable Key casting:

(keycast-mode-line-mode) ;; shows the current binding at the bottom of the selected window, in its mode line.
;; (keycast-header-line-mode) ;; shows the current binding at the top of the selected window, in its header line.
;; (keycast-tab-bar-mode shows) ;; the current binding at the top of the selected frame, in its tab bar.
;; (keycast-log-mode) ;; displays a list of recent bindings in a dedicated frame.

;; You can uncomment this to remove the graphical toolbar at the top. After
;; awhile, you won't need the toolbar.
(when (fboundp 'tool-bar-mode)
   (tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)

;; increase font size for better readability
(set-face-attribute 'default nil :height 140)

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it
;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 177) (height . 53)))

;; These settings relate to how emacs interacts with your operating system
(setq ;; makes killing/yanking interact with the clipboard
      x-select-enable-clipboard t

      ;; I'm actually not sure what this does but it's recommended?
      x-select-enable-primary t

      ;; Save clipboard strings into kill ring before replacing them.
      ;; When one selects something in another program to paste it into Emacs,
      ;; but kills something in Emacs before actually pasting it,
      ;; this selection is gone unless this variable is non-nil
      save-interprogram-paste-before-kill t

      ;; Shows all options when running apropos. For more info,
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
      apropos-do-all t

      ;; Mouse yank commands yank at point instead of at click.
      mouse-yank-at-point t)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell
(setq ring-bell-function 'ignore)

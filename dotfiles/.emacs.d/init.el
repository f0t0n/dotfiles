;; If you hate having this "messy" auto-generated code in your clean init.el,
;; you can tell Emacs to write it to a completely separate file by adding this
;; to the very top of your configuration.
;; This keeps your init.el strictly for your hand-written code and moves the
;; custom-set-variables block to a file called custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Turn on winner-mode to undo and redu windows configuration (splits)
;; Useful, for example to reopen accidentally closed window by hitting C-0
;; instead of C-o
;; Use C-c <left> for Undo
;; Use C-c <right> for Redo
(winner-mode 1)

;; Share clipboard between apps (make able to paste into emacs what was copied
;; into clipboard from other application
(xclip-mode 1)

;; Restore state (splits, buffers) between sessions
(desktop-save-mode 1)

;; Restore lazily: 5 buffers at the start, others - later when is idle
(setq desktop-restore-eager 5)

;; Remembers the exact line and column where your cursor was in every file:
(save-place-mode 1)

;; Preserves your minibuffer command history (like previous M-x commands):
(savehist-mode 1)

;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)

(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)

(setq package-archive-priorities
      '(("melpa-stable" . 10)
        ("melpa" . 5)))
;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(
    ;; Enable cross-application clipboard (requires to run `brew install xclip`)
    xclip
    ;; Fast terminal written in C
    ;; vterm (The Performance Favorite)
    ;; Most commonly used by: Software engineers working on Linux or macOS who
    ;; need speed and 1:1 compatibility with modern terminal apps.
    ;; Why it’s popular: It is written in C (libvterm) rather than Elisp,
    ;; making it significantly faster than any other built-in mode. It handles
    ;; large outputs (like massive logs) and complex "visual" programs
    ;; (like htop, ssh, or even vim inside Emacs) without lagging.
    ;; Best for: Compiling large projects, running interactive CLI tools,
    ;; and daily heavy-duty development.
    ;; Requires to install cmake, libtool, gcc (or clang)
    vterm

    gnu-elpa-keyring-update

    ;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; Common Lisp "IDE"
    slime

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; edit markdown
    markdown-mode

    ;; git integration
    magit

    ;; zenburn theme
    zenburn-theme

    ;; Show current command and its binding
    keycast
    ))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;;
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For Common Lisp programming
(load "common-lisp.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")

;; Load Zenburn Theme
(load-theme 'zenburn t)
(xclip-mode 1)

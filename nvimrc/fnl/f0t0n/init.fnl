(require :f0t0n.set)
(require :f0t0n.remap)

;; Set colorscheme after plugins are loaded
(pcall vim.cmd "colorscheme zenburn")

;; Enable filetype plugins and indent
(vim.cmd "filetype plugin indent on")

;; Syntax highlighting
(vim.cmd "syntax on")

{1 "phha/zenburn.nvim"
 :name "zenburn"
 :config (fn []
           ((. (require "zenburn") :setup))
           (vim.cmd "colorscheme zenburn"))}

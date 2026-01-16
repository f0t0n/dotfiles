{1 "nvim-lualine/lualine.nvim"
 :dependencies ["nvim-tree/nvim-web-devicons"]
 :name "lualine"
 :config (fn []
           ((. (require "lualine") :setup)
            {:options {:theme "zenburn"
                       :extensions ["fzf" "nerdtree"]}}))}

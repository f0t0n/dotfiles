{1 "nvim-tree/nvim-tree.lua"
 :name "nvim-tree"
 :config (fn []
 ((. (require "nvim-tree") :setup)
 {:sort {:sorter "case_sensitive"}
 :view {:width 32}
 :renderer {:group_empty true}
 :filters {:dotfiles false
 :custom ["\\.pyc$" "^__pycache__$"]}}))
 :init (fn []
 (set vim.g.NERDTreeIgnore ["\\.pyc$" "^__pycache__$"])
 (vim.keymap.set :n "<C-n>" ":NvimTreeToggle<CR>" {:desc "Toggle NvimTree"}))
}

return {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree",
    config = function()
        require("nvim-tree").setup({
            -- Configuration docs:
            -- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 32,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
                custom = {
                    "\\.pyc$",
                    "^__pycache__$"
                }
            },
        })
    end,
    init = function()
        vim.g.NERDTreeIgnore = {"\\.pyc$", "^__pycache__$"}
        -- File tree viewer (Ctrl+n to toggle):
        vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>",
            { desc = "Toggle NvimTree" })
    end
}

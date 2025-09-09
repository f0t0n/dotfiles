return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")
        -- ripgrep is required for live_grep and grep_string
        -- and is the first priority for find_files
        -- https://github.com/BurntSushi/ripgrep
        vim.keymap.set("n", "<leader>ff", builtin.find_files,
            { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fr", builtin.git_files,
            { desc = "Telescope Find git Repo files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep,
            { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers,
            { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags,
            { desc = "Telescope help tags" })
    end
}

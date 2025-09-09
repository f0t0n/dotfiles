return {
    "ntpeters/vim-better-whitespace",
    name = "vim-better-whitespace",
    config = function()
        vim.g.better_whitespace_ctermcolor = "LightYellow"
        vim.g.better_whitespace_guicolor = "LightYellow"
        vim.g.better_whitespace_enabled = true
        --vim.g.strip_whitespace_on_save = true
    end
}

return {
--[[
Requires installation of nerd fonts:
    https://github.com/ryanoasis/nerd-fonts

    MacOS:

    brew install font-hack-nerd-font

    Choose nerd font in iTerm settings (Profile -> Text)
]]
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    name = "lualine",
    config = function()
        require("lualine").setup({
            options = {
                theme = "zenburn",
                extensions = {
                    "fzf",
                    "nerdtree"
                }
            }
        })
    end
}

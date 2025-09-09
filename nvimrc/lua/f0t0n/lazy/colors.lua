return {
    "phha/zenburn.nvim",
    name = "zenburn",
    config = function()
        require("zenburn").setup()
        vim.cmd("colorscheme zenburn")
    end
}

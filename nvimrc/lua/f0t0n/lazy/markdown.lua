-- Markdown preview
-- Requires Node.js and yarn to be installed
-- Additional `yarn add tslib` or `npm install tslib` could be required

return {
    "iamcco/markdown-preview.nvim",
    cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop"
    },
    build = "cd app && yarn install && yarn add tslib",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>",
            { desc = "Toggle Markdown Preview" })
    end,
    ft = { "markdown" }
}

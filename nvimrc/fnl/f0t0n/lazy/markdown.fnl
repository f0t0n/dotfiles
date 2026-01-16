{1 "iamcco/markdown-preview.nvim"
 :cmd ["MarkdownPreviewToggle" "MarkdownPreview" "MarkdownPreviewStop"]
 :build "cd app && yarn install && yarn add tslib"
 :init (fn []
         (set vim.g.mkdp_filetypes ["markdown"])
         (vim.keymap.set :n "<leader>mp" ":MarkdownPreviewToggle<CR>" {:desc "Toggle Markdown Preview"}))
 :ft ["markdown"]}

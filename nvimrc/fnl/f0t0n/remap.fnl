(vim.keymap.set :n "<leader>ev"
                (.. ":e " (vim.fn.stdpath :config) "/init.lua<CR>")
                {:silent true :desc "Edit init.lua"})
(vim.keymap.set :n "<leader>sv"
                (.. ":so " (vim.fn.stdpath :config) "/init.lua<CR>")
                {:silent true :desc "Source init.lua"})

(vim.keymap.set :n "<Leader>d" "yyp" {:desc "Duplicate current line"})
(vim.keymap.set :v "<Leader>d" "y'>p" {:desc "Duplicate selection"})

(vim.keymap.set :v "<" "<gv" {:desc "Better indentation"})
(vim.keymap.set :v ">" ">gv" {:desc "Better indentation"})

(vim.keymap.set :v "<Leader>s" ":sort<CR>" {:desc "Sort selected lines"})

(vim.keymap.set :n "<Leader>t" ":tabnew<CR>" {:desc "Open new tab"})
(vim.keymap.set :n "<Leader>tc" ":tabclose<CR>" {:desc "Close current tab"})

(vim.keymap.set :n "<Leader>b" ":enew<CR>" {:desc "Open new buffer"})
(vim.keymap.set :n "<Leader>bq" ":bp | bd #<CR>"
                {:desc "Close current buffer"})
(vim.keymap.set :n "<Leader>," ":bnext<CR>" {:desc "Navigate to next buffer"})
(vim.keymap.set :n "<Leader>." ":bprevious<CR>"
                {:desc "Navigate to previous buffer"})
(vim.keymap.set :n "<Leader>bl" ":ls<CR>" {:desc "Show all open buffers"})

(vim.keymap.set :n "<Leader>h" ":nohl<CR>" {:desc "Remove search highlight"})

(vim.keymap.set :n "<C-j>" "<C-w>j" {:desc "Move to window below"})
(vim.keymap.set :n "<C-k>" "<C-w>k" {:desc "Move to window above"})
(vim.keymap.set :n "<C-l>" "<C-w>l" {:desc "Move to window right"})
(vim.keymap.set :n "<C-h>" "<C-w>h" {:desc "Move to window left"})

(vim.keymap.set :n "<F4>" ":Rg " {:desc "Run Ripgrep"})
(vim.keymap.set :n "<F8>" ":TagbarToggle<CR>" {:desc "Toggle Tagbar"})

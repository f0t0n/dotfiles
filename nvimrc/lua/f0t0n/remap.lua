-- Edit .vimrc (now init.lua)
vim.keymap.set("n",
    "<leader>ev",
    ":e " .. vim.fn.stdpath("config") .. "/init.lua<CR>",
    { silent = true, desc = "Edit init.lua" })
-- Apply changes in .vimrc (now init.lua)
vim.keymap.set("n",
    "<leader>sv",
    ":so " .. vim.fn.stdpath("config") .. "/init.lua<CR>",
    { silent = true, desc = "Source init.lua" })

-- Deal with duplicating the text
vim.keymap.set("n", "<Leader>d", "yyp", { desc = "Duplicate current line" })
vim.keymap.set("v", "<Leader>d", "y'>p", { desc = "Duplicate selection" })

-- Easier moving of code blocks
vim.keymap.set("v", "<", "<gv", { desc = "Better indentation" })
vim.keymap.set("v", ">", ">gv", { desc = "Better indentation" })

vim.keymap.set("v", "<Leader>s", ":sort<CR>", { desc = "Sort selected lines" })

-- Deal with tabs
vim.keymap.set("n", "<Leader>t", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<Leader>tc", ":tabclose<CR>",
    { desc = "Close current tab" })
-- vim.keymap.set("n", "<Leader>,", ":tabnext<CR>", { desc = "Navigate to next tab" })
-- vim.keymap.set("n", "<Leader>.", ":tabprevious<CR>", { desc = "Navigate to previous tab" })

-- Deal with buffers
vim.keymap.set("n", "<Leader>b", ":enew<CR>", { desc = "Open new buffer" })
vim.keymap.set("n", "<Leader>bq", ":bp | bd #<CR>",
    { desc = "Close current buffer" })
vim.keymap.set("n", "<Leader>,", ":bnext<CR>",
    { desc = "Navigate to next buffer" })
vim.keymap.set("n", "<Leader>.", ":bprevious<CR>",
    { desc = "Navigate to previous buffer" })
vim.keymap.set("n", "<Leader>bl", ":ls<CR>",
    { desc = "Show all open buffers" })

-- Bind nohl (remove hilighted results of last search)
vim.keymap.set("n", "<Leader>h", ":nohl<CR>",
    { desc = "Remove search highlight" })

-- Bind Ctrl+<movement> to move between windows (splits)
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })

-- Ripgrep hot key
vim.keymap.set("n", "<F4>", ":Rg ", { desc = "Run Ripgrep" })

-- Tagbar hot key
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>", { desc = "Toggle Tagbar" })


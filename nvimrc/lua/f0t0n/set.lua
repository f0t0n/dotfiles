-- This must be first, because it changes other options as side effect
vim.opt.compatible = false -- be iMproved, required
vim.opt.filetype = "off"   -- required

-- Set leader key
vim.g.mapleader = ","

-- Encoding
vim.opt.encoding = "utf-8" -- Necessary to show Unicode glyphs

-- Clipboard
-- Check if the system is macOS (Darwin) or Linux
if vim.fn.system('uname -s'):match("Darwin") then
    vim.opt.clipboard = "unnamed" -- macOS
else
    vim.opt.clipboard = "unnamedplus" -- Linux
end

vim.opt.re = 0
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.wrap = false
vim.opt.textwidth = 79
vim.opt.colorcolumn = "80"
vim.opt.formatoptions:remove("t")
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.laststatus = 2   -- Always show the statusline
vim.opt.showtabline = 2  -- Always display the tabline, even if there is only one tab
-- With Vim Powerline hide the default mode text
-- (e.g. -- INSERT -- below the statusline):
vim.opt.showmode = false

vim.opt.mouse = "a"
vim.opt.backspace = "indent,eol,start" -- make backspace behave like normal again
vim.opt.wildignore:append("*.pyc")

-- Disable stupid backup and swap files - they trigger too many events
-- for file system watchers
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.shortmess:remove("S")    -- show N/M while searching

-- Use 256 colours (Use this setting only if your terminal supports 256 colours)
vim.opt.termguicolors = true -- Neovim prefers termguicolors for true color support

-- Show white spaces
vim.opt.listchars = "eol:¬,tab:┊\\ "
vim.opt.list = true


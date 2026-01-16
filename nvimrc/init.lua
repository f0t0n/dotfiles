local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Bootstrap hotpot
local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
if vim.loop.fs_stat(hotpotpath) then
    vim.opt.rtp:prepend(hotpotpath)
    require("hotpot").setup()
end

vim.g.mapleader = ","

-- Load specs from Fennel
local plugins = require("f0t0n.lazy")
-- Add hotpot to the plugins list
table.insert(plugins, 1, { "rktjmp/hotpot.nvim", lazy = false, priority = 1000, config = true })

require("lazy").setup(plugins)

-- Load the rest of the config
require("f0t0n")
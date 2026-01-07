-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- Number of spaces for each indentation
vim.opt.tabstop = 2 -- Number of spaces that a tab counts for
vim.opt.softtabstop = 2
vim.opt.colorcolumn = { "120", "160" }
vim.opt.fileformats = { "unix", "dos" }

vim.g.autoformat = true
vim.g.bigfile_size = 2 * 1024 * 1024

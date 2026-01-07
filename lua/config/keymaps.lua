-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = require("utils.keymapUtils").map
local lmap = require("utils.keymapUtils").lmap
local opt = require("utils.keymapUtils").opt

vim.g.mapleader = " "
vim.g.ctrlp_show_hidden = 1

--vim default keybindings remap
map("i", "(", "()<Esc>i", opt())
map("i", "{", "{}<Esc>i", opt())
map("i", "[", "[]<Esc>i", opt())

map("n", "<C-w>", ":lua Snacks.bufdelete.delete()<cr>", opt())
map("n", "<C-q>", ":bd<cr>", opt())
lmap("n", "<C-s>", ":w<cr>", { desc = "save file" })
lmap("i", "<C-s>", "<esc><esc>:w<cr>", { desc = "save file" })
map("n", "<Tab>", ":BufferLineCycleNext<cr>", opt())
map("n", "<S-Tab>", ":BufferLineCyclePrev<cr>", opt())
map("n", "<C-x>", ":BufferLineTogglePin<cr>", opt())

map("i", "jj", "<Esc>", opt())
map("i", "kk", "<Esc>", opt())
map("i", "<C-e>", "<Esc> <S-$>a", opt())

map("n", "W", "ciw", opt()) -- change word
map("n", "<C-d>", "yyp", opt()) -- duplicate line

-- Window
--Map('n', '<Leader>w/', ':vsplit<cr>', Opt())
map("n", "sv", ":vsplit<cr>", opt())
map("n", "ss", ":split<cr>", opt())
--Map('n', '<Leader>w-', ':split<cr>', Opt())
map("n", "<Leader>wh", ":wincmd h<cr>", opt())
map("n", "<Leader>wj", ":wincmd j<cr>", opt())
map("n", "<Leader>wk", ":wincmd k<cr>", opt())
map("n", "<Leader>wl", ":wincmd l<cr>", opt())
map("n", "+", ":vertical resize +10<CR>", opt())
map("n", "_", ":vertical resize -10<CR>", opt())

-- actions
map("n", "<leader>u", ":UndotreeToggle<cr>", opt())

-- move line
map("v", "J", ":m '>+1<CR>gv=gv", opt())
map("v", "K", ":m '<-2<CR>gv=gv", opt())
map("i", "<C-j>", "<esc>:m .+1<CR>==", opt())
map("i", "<C-k>", "<esc>:m .-2<CR>==", opt())
map("n", "<Leader>j", ":m .+1<CR>==", opt())
map("n", "<Leader>k", ":m .-2<CR>==", opt())
map("v", ">", ">gv", opt())
map("v", "<", "<gv", opt())

-- Comment
map("n", "<leader>;", "<plug>NERDCommenterToggle", opt())
map("v", "<leader>;", "<plug>NERDCommenterToggle", opt())
map("x", "<leader>;", "<plug>NERDCommenterToggle", opt())
map("n", "gc", "<plug>NERDCommenterToggle", opt())
map("v", "gc", "<plug>NERDCommenterToggle", opt())
map("x", "gc", "<plug>NERDCommenterToggle", opt())

-- better wrap line
map("n", "<C-j>", "i<cr><Tab><esc>", opt())
map("n", "<C-k>", "hvb<S-e>ld<esc>", opt())

-- better navigation
map("i", "<C-k>", "<up>", opt())
map("i", "<C-j>", "<down>", opt())
map("i", "<C-h>", "<left>", opt())
map("i", "<C-l>", "<right>", opt())

-- Tmux
map("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>")
map("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>")
map("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>")
map("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>")

-- editor
map("n", "<leader>fr", ":source<CR> <bar>:lua vim.notify('File reloaded')<cr>", opt())
map("n", "<leader>lr", ":LspRestart<cr>", { desc = "restart lsp" })

-- lsp
map("n", "<C-.>", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "code actions" })
map("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "goto implementation" })

map({ "n", "v" }, "<C-.>", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
map("n", "<leader>ff", function()
  require("conform").format()
end, { desc = "format" })
map("n", "<leader>ss", function()
  Snacks.picker.lsp_symbols()
end, { desc = "goto symbols" })

lmap("v", "<leader>sw", function()
  vim.cmd('normal! "vy')
  local text = vim.fn.getreg("v")
  require("telescope.builtin").grep_string({ search = text })
end, { desc = "Grep selection with Telescope" })

return {
  map,
  opt,
}

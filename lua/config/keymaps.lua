-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
vim.g.ctrlp_show_hidden = 1

function Map(mode, key, command, opt, desc)
  vim.api.nvim_set_keymap(mode, key, command, opt or Opt())
end

function Opt(desc, silent, noremap, expr)
  return {
    silent = silent or true,
    noremap = noremap or true,
    expr = expr or false,
    desc = desc or nil,
  }
end

--vim default keybindings remap
Map("i", "(", "()<Esc>i", Opt())
Map("i", "{", "{}<Esc>i", Opt())
Map("i", "[", "[]<Esc>i", Opt())

Map("n", "<C-w>", ":bd<cr>", Opt())
Map("n", "<C-q>", ":bd<cr>", Opt())
Map("n", "<C-s>", ":w<cr>", Opt())
Map("i", "<C-s>", "<esc><esc>:w<cr>", Opt())
Map("n", "<Tab>", ":BufferLineCycleNext<cr>", Opt())
Map("n", "<S-Tab>", ":BufferLineCyclePrev<cr>", Opt())

Map("i", "jj", "<Esc>", Opt())
Map("i", "kk", "<Esc>", Opt())
Map("i", "<C-e>", "<Esc> <S-$>a", Opt())

Map("n", "W", "ciw", Opt()) -- change word
Map("n", "<C-d>", "yyp", Opt()) -- duplicate line

-- Window
--Map('n', '<Leader>w/', ':vsplit<cr>', Opt())
Map("n", "sv", ":vsplit<cr>", Opt())
Map("n", "ss", ":split<cr>", Opt())
--Map('n', '<Leader>w-', ':split<cr>', Opt())
Map("n", "<Leader>wh", ":wincmd h<cr>", Opt())
Map("n", "<Leader>wj", ":wincmd j<cr>", Opt())
Map("n", "<Leader>wk", ":wincmd k<cr>", Opt())
Map("n", "<Leader>wl", ":wincmd l<cr>", Opt())
Map("n", "+", ":vertical resize +10<CR>", Opt())
Map("n", "_", ":vertical resize -10<CR>", Opt())

-- actions
Map("n", "<leader>u", ":UndotreeToggle<cr>", Opt())

-- move line
Map("v", "J", ":m '>+1<CR>gv=gv", Opt())
Map("v", "K", ":m '<-2<CR>gv=gv", Opt())
Map("i", "<C-j>", "<esc>:m .+1<CR>==", Opt())
Map("i", "<C-k>", "<esc>:m .-2<CR>==", Opt())
Map("n", "<Leader>j", ":m .+1<CR>==", Opt())
Map("n", "<Leader>k", ":m .-2<CR>==", Opt())
Map("v", ">", ">gv", Opt())
Map("v", "<", "<gv", Opt())

-- Comment
Map("n", "<leader>;", "<plug>NERDCommenterToggle", Opt())
Map("v", "<leader>;", "<plug>NERDCommenterToggle", Opt())
Map("x", "<leader>;", "<plug>NERDCommenterToggle", Opt())
Map("n", "gc", "<plug>NERDCommenterToggle", Opt())
Map("v", "gc", "<plug>NERDCommenterToggle", Opt())
Map("x", "gc", "<plug>NERDCommenterToggle", Opt())

-- better wrap line
Map("n", "<C-j>", "i<cr><Tab><esc>", Opt())
Map("n", "<C-k>", "hvb<S-e>ld<esc>", Opt())

-- better navigation
Map("i", "<C-k>", "<up>", Opt())
Map("i", "<C-j>", "<down>", Opt())
Map("i", "<C-h>", "<left>", Opt())
Map("i", "<C-l>", "<right>", Opt())

-- Tmux
Map("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>")
Map("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>")
Map("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>")
Map("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>")

-- editor
Map("n", "<leader>fr", ":source<CR> <bar>:lua vim.notify('File reloaded')<cr>", Opt())

--FZF lua
Map("n", "<leader>sf", "<Cmd>FzfLua files<CR>", Opt("Find files"))
Map("n", "<leader>sp", "<Cmd>FzfLua grep_project<CR>", Opt("Search word"))

-- lsp remap
local keys = require("lazyvim.plugins.lsp.keymaps").get()

-- lsp
keys[#keys + 1] = { "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", desc = "implementation" }
keys[#keys + 1] = { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>" }
keys[#keys + 1] = {
  "<leader>ff",
  function()
    require("conform").format()
  end,
  desc = "Format",
}

keys[#keys + 1] = {
  "<leader>ss",
  function()
    Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter })
  end,
  desc = "Symbols in file",
}

-- finder
keys[#keys + 1] = { "gr", "<Cmd>Lspsaga finder<CR>" }
keys[#keys + 1] = { "gd", "<Cmd>lua vim.lsp.buf.definition()<cr>" }

--keys[#keys + 1] = { "gd", "<Cmd>Trouble lsp_definitions<cr>" }

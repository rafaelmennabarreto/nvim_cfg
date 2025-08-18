local m = {}

m.opt = function(desc, silent, noremap, expr)
  return {
    silent = silent or true,
    noremap = noremap or true,
    expr = expr or false,
    desc = desc or nil,
  }
end

m.map = function(mode, key, command, opt, desc)
  vim.api.nvim_set_keymap(mode, key, command, opt or m.opt())
end

return m

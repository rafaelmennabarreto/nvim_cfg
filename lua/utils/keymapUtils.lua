local m = {}

local map = LazyVim.safe_keymap_set

m.opt = function(desc, silent, noremap, expr)
  return {
    silent = silent or true,
    noremap = noremap or true,
    expr = expr or false,
    desc = desc or nil,
  }
end

m.map = function(mode, key, command, opt)
  vim.keymap.set(mode, key, command, opt or m.opt())
end

m.lmap = map

return m

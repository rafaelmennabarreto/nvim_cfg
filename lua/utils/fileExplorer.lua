local m = {}

m.open = function()
  require("neo-tree.command").execute({ toggle = true })
end

m.open_item = function(state)
  local node = state.tree:get_node()

  if require("neo-tree.utils").is_expandable(node) then
    state.commands["toggle_node"](state)
  else
    state.commands["open"](state)
    vim.cmd("Neotree close")
  end
end

return m

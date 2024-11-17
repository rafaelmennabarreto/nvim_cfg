local fileExplorer = require("utils.fileExplorer")
return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    { "<leader>oe", fileExplorer.open, desc = "Explorer NeoTree (root dir)", remap = true },
    { "<C-b>",      "<leader>oe",      desc = "Explorer NeoTree (root dir)", remap = true },
  },
  opts = function(_, opts)
    opts.window.mappings = {
      ["o"] = fileExplorer.open_item,
      ["h"] = "close_node",
      ["n"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["N"] = "add_directory",
    }

    opts.window.width = vim.o.columns
  end,
}

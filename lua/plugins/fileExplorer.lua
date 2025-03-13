local fileExplorer = require("utils.fileExplorer")
return {
  {
    "echasnovski/mini.files",
    enabled = false,
    keys = {
      {
        "<leader>oe",
        ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
        desc = "Explorer mini files",
        remap = true,
      },
    },
    config = function()
      require("mini.files").setup({
        -- Customization of shown content
        content = {
          -- Predicate for which file system entries to show
          filter = nil,
          -- What prefix to show to the left of file system entry
          prefix = nil,
          -- In which order to show file system entries
          sort = nil,
        },

        -- Module mappings created only inside explorer.
        -- Use `''` (empty string) to not create one.
        mappings = {
          close = "q",
          go_in = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
          mark_goto = "'",
          mark_set = "m",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },

        -- General options
        options = {
          -- Whether to delete permanently or move into module-specific trash
          permanent_delete = true,
          -- Whether to use for editing directories
          use_as_default_explorer = true,
        },

        -- Customization of explorer windows
        windows = {
          -- Maximum number of windows to show side by side
          max_number = 2,
          -- Whether to show preview of file/directory under cursor
          preview = false,
          -- Width of focused window
          width_focus = 50,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 25,
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    --branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>oe", fileExplorer.open, desc = "Explorer NeoTree (root dir)", remap = true },
      { "<C-b>", "<leader>oe", desc = "Explorer NeoTree (root dir)", remap = true },
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
  },
}

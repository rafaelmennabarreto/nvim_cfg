local fileExplorer = require("utils.fileExplorer")

return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>oe",
        "<cmd>lua Snacks.explorer.open()<cr>",
        desc = "Gitsigns blame line",
        remap = true,
      },
    },
    ---@type snacks.Config
    opts = {
      explorer = {
        -- your explorer configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            layout = {
              fullscreen = true,
            },
            win = {
              list = {
                keys = {
                  ["<BS>"] = "explorer_up",
                  ["l"] = "confirm",
                  ["h"] = "explorer_close", -- close directory
                  ["n"] = "explorer_add",
                  ["d"] = "explorer_del",
                  ["r"] = "explorer_rename",
                  ["c"] = "explorer_copy",
                  ["m"] = "explorer_move",
                  ["o"] = "confirm",
                  ["P"] = "toggle_preview",
                  ["y"] = { "explorer_yank", mode = { "n", "x" } },
                  ["p"] = "explorer_paste",
                  ["u"] = "explorer_update",
                  ["<c-c>"] = "tcd",
                  ["<leader>/"] = "picker_grep",
                  ["<c-t>"] = "terminal",
                  ["."] = "explorer_focus",
                  ["I"] = "toggle_ignored",
                  ["H"] = "toggle_hidden",
                  ["Z"] = "explorer_close_all",
                  ["]g"] = "explorer_git_next",
                  ["[g"] = "explorer_git_prev",
                  ["]d"] = "explorer_diagnostic_next",
                  ["[d"] = "explorer_diagnostic_prev",
                  ["]w"] = "explorer_warn_next",
                  ["[w"] = "explorer_warn_prev",
                  ["]e"] = "explorer_error_next",
                  ["[e"] = "explorer_error_prev",
                },
              },
            },
          },
        },
      },
    },
  },

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
    enabled = false,
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

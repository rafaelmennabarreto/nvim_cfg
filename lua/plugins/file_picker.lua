local telescopeUtils = require("utils.telescopeUtils")
local map = require("utils.keymapUtils").lmap

return {
  {
    --disabled fzf lua to telescope work fine
    "ibhagwan/fzf-lua",
    enabled = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    enabled = true,
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      {
        "<leader>sf",
        telescopeUtils.find_file,
        desc = "Telescope find files",
        remap = true,
      },
      {
        "<leader>sp",
        ":Telescope live_grep<cr>",
        desc = "Telescope grep string",
        remap = true,
      },
      {
        "<leader>sw",
        ":Telescope grep_string<cr>",
        desc = "Telescope grp string",
        remap = true,
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local telescope = require("telescope")

      map("v", "<leader>sw", function()
        vim.cmd('normal! "vy')
        local text = vim.fn.getreg("v")
        require("telescope.builtin").grep_string({ search = text })
      end, { desc = "Grep selection with Telescope" })

      opts.defaults = {
        winblend = 18,
        layout_strategy = "horizontal",
        path_display = { filename_first = true, truncate = 4 },
        mappings = {
          n = {
            ["<Esc>"] = actions.close,
            ["q"] = actions.close,
            ["o"] = actions.select_default,
          },
          i = {
            ["<Esc>"] = actions.close,
            ["<C-w>"] = actions.close,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      }

      telescope.setup(opts)
      --require('telescope').load_extension("file_browser")
    end,
  },
}

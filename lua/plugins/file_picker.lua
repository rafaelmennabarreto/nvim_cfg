local telescopeUtils = require("utils.telescopeUtils")

local win_config = function()
  local height = math.floor(0.618 * vim.o.lines)
  local width = math.floor(0.618 * vim.o.columns)
  return {
    anchor = "NW",
    border = "rounded",
    height = height,
    width = width,
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end

return {
  {
    "echasnovski/mini.pick",
    version = "*",
    enabled = false,
    keys = {
      { "<leader>sf", ":Pick files <cr>", desc = "MIni Find files", remap = true },
      { "<leader>sp", ":Pick grep_live <cr>", desc = "MIni Grep files", remap = true },
    },
    config = function()
      require("mini.pick").setup({
        mappings = {
          move_down = "<C-j>",
          move_up = "<C-k>",
          paste = "<C-r>",
        },
        window = {
          -- Float window config (table or callable returning it)
          config = win_config,

          -- String to use as caret in prompt
          prompt_caret = " ",

          -- String to use as prefix in prompt
          prompt_prefix = "  ",
        },
      })
    end,
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
        telescopeUtils.find_word,
        desc = "Telescope find word",
        remap = true,
      },
      --{
      --"<leader>oe",
      --telescopeUtils.fileExplorer,
      --desc = "file explorer",
      --remap = true,
      --},
      { "<leader>sw", ":Telescope grep_string<cr>", desc = "Grep String", remap = true },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local telescope = require("telescope")

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

local telescopeUtils = require("utils.telescopeUtils")

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    --{
      --"<leader>sf",
      --telescopeUtils.find_file,
      --desc = "Telescope find files",
      --remap = true,
    --},
    --{
      --"<leader>sp",
      --telescopeUtils.find_word,
      --desc = "Telescope find word",
      --remap = true,
    --},
    --{
      --"<leader>oe",
      --telescopeUtils.fileExplorer,
      --desc = "file explorer",
      --remap = true,
    --},
    --{
      --"<C-b>",
      --telescopeUtils.fileExplorer,
      --desc = "file explorer",
      --remap = true,
    --},
  },
  opts = function(_, opts)
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    opts.defaults = {
      winblend     = 15,
      path_display = { "truncate=3" },
      mappings     = {
        n = {
          ["q"] = actions.close,
          ["o"] = actions.select_default,
        },
        i = {
          ["<C-w>"] = actions.close,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      }
    }

    --local fb_actions = require "telescope".extensions.file_browser.actions
    --opts.extensions = {
      --file_browser = {
        --preview = false,
        --path_display = { "tail" },
        --path = "%:p:h",
        --grouped = true,
        --respect_gitignore = true,
        --layout_config = {
          --height = 40,
          --width = 105
        --},
        ---- disables netrw and use telescope-file-browser in its place
        --hijack_netrw = true,
        --mappings = {
          --i = {
          --},
          --n = {
            --["<S-n>"] = fb_actions.create,
            --["h"] = fb_actions.goto_parent_dir,
            --["y"] = fb_actions.copy,
            --["m"] = fb_actions.move,
            --["/"] = function()
              --vim.cmd('startinsert')
            --end
          --}
        --}
      --},
    --}

    telescope.setup(opts)
    --require('telescope').load_extension("file_browser")
  end,
}

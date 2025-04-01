return {
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>gb",
        "<cmd>Gitsigns blame_line<cr>",
        desc = "Gitsigns blame line",
        remap = true,
      },
    },
  },
}

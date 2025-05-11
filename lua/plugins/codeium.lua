--937667b2cadc7905e6b9ba18ecf84694cf227567
return {
  "Exafunction/windsurf.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({})
  end,
}

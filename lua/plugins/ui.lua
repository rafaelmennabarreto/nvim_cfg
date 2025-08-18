local themes = require("utils.lualine_themes")

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = themes.buubles,
  },
}

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    priority = 1000,
    opts = function()
      require("catppuccin").setup({
        flavour = "auto",               -- latte, frappe, macchiato, mocha
        transparent_background = false, -- disables setting the background color.
      })

      vim.cmd("colorscheme catppuccin")
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    enabled = false,
    opts = function()
      require("rose-pine").setup({
        variant = "moon", -- auto, main, moon, or dawn
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = true,
    opts = function()
      require("kanagawa").setup({
        compile = false,
        transparent = true,
        theme = "dragon",
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        },
      })

      vim.cmd("colorscheme kanagawa")
    end
  },
}

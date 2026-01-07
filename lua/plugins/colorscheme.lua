return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "edge",
    },
  },
  {
    "NTBBloodbath/doom-one.nvim",
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    priority = 1000,
    init = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
      })
    end,
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
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    opts = function()
      require("kanagawa").setup({
        compile = false,
        transparent = true,
        theme = "dragon",
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    enabled = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "sainnhe/edge",
    lazy = true,
    enabled = true,
    priority = 1000,
    opts = function()
      vim.g.edge_transparent_background = 1
      vim.g.edge_enable_italic = true
      vim.g.edge_style = "aura"
      vim.g.edge_better_performance = 1
    end,
  },
}

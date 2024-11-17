return {
  'nvimdev/lspsaga.nvim',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lspsaga').setup({
      symbol_in_winbar = {
        enable = false, -- Desabilita os breadcrumbs
      },
      ui = {
        code_action = ""
      }
    })
  end,
}

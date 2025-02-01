return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "angular-language-server",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
      })

      opts.automatic_installation = false
    end
  }
}

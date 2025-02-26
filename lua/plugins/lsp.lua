local fileUtils = require("utils.fileUtils")

return {
  {
    "stevearc/conform.nvim",
    init = function()
      require("conform").setup({
        format_on_save = {
          lsp_fallback = true, -- Usa o LSP como fallback caso não tenha formatador configurado
        },
        --formatters = {
        --eslint_fix = {
        --command = "eslint_fix",
        --args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
        --stdin = true,
        --},
        --},
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          javascript = { "eslint_d", "prettierd", "prettier" },
          typescript = { "eslint_d", "prettierd", "prettier" },
          html = { "prettier", "prettierd" },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "tamago324/nlsp-settings.nvim",
    },
    keys = {
      { "<C-n>", "<Cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next error" },
      { "<C-p>", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous error" },
      { "<leader>ll", "<cmd>Lazy<cr>", desc = "Lazy plugins" },
      { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Lsp Restart" },
      { "<leader>rp", "*:%s///g<left><left>", desc = "Replace all occurences" },
      { "<leader>rn", "<Cmd>Lspsaga rename<cr>", desc = "Replace references" },
      { "<leader>.", "<Cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code actions" },
      { "<leader>od", "<Cmd>Trouble diagnostics<CR>", desc = "File diagnostics" },
      { "gr", "<Cmd>Trouble lsp_references<CR>", desc = "lsp references" },
    },
    opts = function(_, config)
      config.inlay_hints = { enabled = false }
      config.autoformat = false

      config.diagnostics.float = {
        border = "rounded",
      }

      return config
    end,
  },
}

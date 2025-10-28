local map = require("utils.keymapUtils").map

return {
  {
    "stevearc/conform.nvim",
    opts = function()
      ---@type conform.setupOpts
      local opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          javascript = { "eslint_d", "prettierd" },
          typescript = { "eslint_d", "prettierd" },
          html = { "prettierd", lsp_format = "fallback" },
          htmlangular = { "prettierd", lsp_format = "fallback" },
          css = { "prettierd", lsp_format = "fallback" },
          scss = { "prettierd", lsp_format = "fallback" },
          gopls = { "gofumpt", lsp_format = "fallback" },
        },
        default_format_opts = {
          lsp_format = "fallback",
          timeout_ms = 1500,
        },
      }

      return opts
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    enabled = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false, -- Desabilita os breadcrumbs
        },
        ui = {
          code_action = "",
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "angular-language-server",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "eslint_d",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "prettierd",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
      })

      opts.automatic_installation = false
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<C-n>", "<Cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next error" },
      { "<C-p>", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous error" },
      { "<leader>ll", "<cmd>Lazy<cr>", desc = "Lazy plugins" },
      { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Lsp Restart" },
      { "<leader>rp", "*:%s///g<left><left>", desc = "Replace all occurences" },
      { "<leader>rn", "<Cmd>Lspsaga rename<cr>", desc = "Replace references" },
      { "<leader>.", "<Cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code actions" },
      { "<leader>od", "<Cmd>Trouble diagnostics<CR>", desc = "File diagnostics" },
    },
    opts = {
      inlay_hints = { enabled = false },
      autoformat = vim.g.autoformat,
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
      tsserver = {
        enabled = false,
      },
      servers = {
        ["*"] = {
          organize_imports_on_format = true,

          keys = {
            { "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", desc = "goto implementation" },
            { "gd", "<Cmd>Telescope lsp_definitions<cr>", desc = "goto definitions" },
            { "gr", "<Cmd>Lspsaga finder<CR>", desc = "goto references" },
            { "<C-.>", "<Cmd>lua vim.lsp.buf.code_action()<CR>", desc = "code actions" },
            {
              "<leader>ff",
              function()
                require("conform").format()
              end,
              desc = "Format",
            },
            {
              "<leader>ss",
              function()
                Snacks.picker.lsp_symbols()
              end,
              desc = "goto symbol",
            },
          },
        },
      },
    },
  },
}

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
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "python",
          "bash",
          "markdown",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = { enable = true },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    version = "*",
    keys = {
      --vim.lsp.buf.definition
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
        diagnostics = {
          underline = true,
          update_in_insert = false, -- <- evita lag digitando
          virtual_text = { spacing = 2, prefix = "●" },
          severity_sort = true,
        },
        flags = {
          debounce_text_changes = 150,
          allow_incremental_sync = true,
        },
        on_attach = function(client)
          --client.server_capabilities.documentFormattingProvider = false
          --client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
      vtsls = {
        enabled = true,
        settings = {
          typescript = {
            inlayHints = {
              enable = false,
            },
          },
          javascript = {
            inlayHints = {
              enable = false,
            },
          },
        },
      },
      servers = {
        ["*"] = {
          organize_imports_on_format = true,
          keys = {
            { "gd", "<Cmd> Lspsaga goto_definition<CR>", desc = "Previous error" },
            {
              "gi",
              "<Cmd>lua vim.lsp.buf.implemenlua vim.lsp.buf.definition()tation()<CR>",
              desc = "goto implementation",
            },
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

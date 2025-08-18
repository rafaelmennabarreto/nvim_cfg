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
    "mason-org/mason-lspconfig.nvim",
    --TODO: remove this line before lazyvim update
    version = "^1.0.0",
  },
  {
    "williamboman/mason.nvim",
    --TODO: remove this line before lazyvim update
    version = "^1.0.0",
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
    },
    opts = function(_, config)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", desc = "implementation" }
      --keys[#keys + 1] = { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>" }
      keys[#keys + 1] = { "gr", "<Cmd>Lspsaga finder<CR>" }
      keys[#keys + 1] = { "gd", "<Cmd>Lspsaga goto_definition<cr>" }
      --keys[#keys + 1] = { "gd", "<Cmd>lua vim.lsp.buf.definition()<cr>" }

      keys[#keys + 1] = {
        "<leader>ff",
        function()
          require("conform").format()
        end,
        desc = "Format",
      }

      keys[#keys + 1] = {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "Symbols in file",
      }

      config.inlay_hints = { enabled = false }
      config.autoformat = vim.g.autoformat

      config.diagnostics.float = {
        border = "rounded",
      }

      return config
    end,
  },
}

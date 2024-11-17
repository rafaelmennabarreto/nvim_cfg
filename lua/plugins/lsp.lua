local fileUtils = require("utils.fileUtils")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'tamago324/nlsp-settings.nvim',
  },
  keys = {
    { "<C-n>",      "<Cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next error" },
    { "<C-p>",      "<Cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous error" },
    { "<leader>ll", "<cmd>Lazy<cr>",                           desc = "Symbols Outline" },
    { "<leader>lr", "<cmd>LspRestart<cr>",                     desc = "Symbols Outline" },
    { "<leader>rp", "*:%s///g<left><left>",                    desc = "Replace" },
    { "<leader>rn", "<Cmd>Lspsaga rename<cr>",                 desc = "Replace" },
    { "<leader>ff", "<Cmd>lua vim.lsp.buf.format()<CR>",       desc = "Format" },
    { "<leader>.",  "<Cmd>lua vim.lsp.buf.code_action()<CR>",  desc = "Code actions" },
    { "<leader>od", "<Cmd>Trouble diagnostics<CR>",            desc = "File diagnostics" },
    { "gr",         "<Cmd>Trouble lsp_references<CR>",         desc = "lsp references" }
  },
  init = function(_, opts)
    print(vim.inspect(opts))

    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    -- change a keymap
    keys[#keys + 1] = { "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>" }
    keys[#keys + 1] = { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>" }

    -- trouble
    keys[#keys + 1] = { "gr", "<Cmd>Trouble lsp_references<CR>" }

    keys[#keys + 1] = { "gd", "<Cmd>lua vim.lsp.buf.definition()" }

    require('nlspsettings').setup({
      config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
      local_settings_dir = ".nlsp-settings",
      local_settings_root_markers_fallback = { '.git' },
      append_default_schemas = true,
      loader = 'json'
    })
  end,
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      eslint = {},
      html = {},
      angularls = {}
    },
    autoformat = false,
    diagnostics = {
      float = {
        border = "rounded",
      },
    },
    setup = {
      angularls = function()
        LazyVim.lsp.on_attach(function(client)
          local project_dir = fileUtils.get_root_dir() .. '/node_modules/'
          --local volta_angularls = fileUtils.get_volta_root() .. '/tools/shared/@angular/language-server/node_module/'
          --local lazy_angularls = LazyVim.get_pkg_path("angular-language-server", "/node_modules/@angular/language-server")
          --
          local angular_server_path = LazyVim.get_pkg_path("angular-language-server")
          local lazy_angularls = angular_server_path .. "/node_modules/@angular/language-server"
          local lazy_angularTs = angular_server_path .. "/node_modules/"


          client.config.cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            lazy_angularTs,
            "--ngProbeLocations",
            lazy_angularls,
            "--viewEngine",
            "--project",
            project_dir
          }

          client.server_capabilities.renameProvider = false
        end, "angularls")
      end,
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
      html = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name ~= "html" then return end

          client.settings = {
            html = {
              format = {
                wrapAttributes = "force-aligned",
                wrapLineLength = 500,
                wrapAttributesIndentSize = 50
              }
            }
          }
        end)
      end,
    },
  }
}

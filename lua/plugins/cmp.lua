return {
  {
    "Saghen/blink.cmp",
    --version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      --snippets = { preset = "luasnip" },
      keymap = {
        preset = "enter", -- Preset que define o comportamento padrão das teclas
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" }, -- Mapeia <Tab> para navegar e expandir snippets
        ["<S-Tab>"] = { "select_prev", "snippet_backward" }, -- Mapeia Shift+<Tab> para navegar para trás e retroceder snippets
        ["<Esc>"] = { "fallback_to_mappings" },
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = false,
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
        menu = {
          draw = {
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", gap = 1 },
              { "kind", gap = 1 },
            },
          },
        },
        list = { selection = { preselect = false, auto_insert = true } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "codeium" },
        providers = {
          codeium = { name = "Codeium", module = "codeium.blink", async = true },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    --opts_extend = { "sources.default" },
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
      "hrsh7th/cmp-emoji",
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lua",
    },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })

      local source_names = {
        nvim_lsp = "[LSP]",
        emoji = "[Emoji]",
        path = "[Path]",
        calc = "[Calc]",
        vsnip = "[Snippet]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        tmux = "[TMUX]",
        codeium = "[AI]",
        git = "[Git]",
        nvim_lua = "[Lua]",
      }

      local icons = {
        Text = "󰉿", -- Letra A estilizada
        Method = "󰆧", -- Função com argumentos
        Function = "󰊕", -- Ícone de função
        Constructor = "", -- Chave inglesa para construtores
        Field = "󰜢", -- Campo/atributo
        Variable = "󰀫", -- Variável
        Class = "󰠱", -- Classe
        Interface = "", -- Interface (estrutura)
        Module = "", -- Módulo/Pacote
        Property = "󰜢", -- Propriedade (similar a Field)
        Unit = "", -- Unidade
        Value = "󰎠", -- Valor constante
        Enum = "", -- Enumeração (lista)
        Keyword = "󰌋", -- Palavra-chave
        Snippet = "", -- Trecho de código
        Color = "󰏘", -- Paleta de cores
        File = "󰈙", -- Arquivo
        Reference = "󰈇", -- Referência
        Folder = "󰉋", -- Pasta
        EnumMember = "", -- Membro de Enum
        Constant = "󰏿", -- Constante
        Struct = "", -- Estrutura (parecido com classe)
        Event = "", -- Evento (relâmpago)
        Operator = "󰆕", -- Operador (matemático)
        TypeParameter = "󰊄", -- Parâmetro de tipo
        Namespace = "󰌗", -- Namespace
        Package = "󰏓", -- Pacote
        Boolean = "", -- Booleano (V/F)
        Number = "󰎠", -- Número
        String = "󰀬", -- String (texto)
        Array = "󰅪", -- Array (lista)
        Object = "󰀚", -- Objeto genérico
        Null = "󰟢", -- Nulo (null)
        Key = "󰌋", -- Chave (mapa/dicionário)
        Codeium = "󰘦", -- Ícone especial para IA (Codeium)
        Win = "󰍰", -- Janela
      }

      opts.window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        },
      }

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = true,
        max_width = 0,
        format = function(entry, vim_item)
          vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
          vim_item.menu = source_names[entry.source.name]
          vim_item.kind = (icons[vim_item.kind] or vim_item.kind) .. " "
          return vim_item
        end,
      }

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emoji" },
        { name = "git" },
        { name = "nvim_lua" },
      }))

      opts.sorting = {
        comparators = {
          function(entry1, entry2)
            if entry1.completion_item.label == entry2.completion_item.label then
              return false -- Remove entradas duplicadas
            end
            return nil -- Continua ordenação normal
          end,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
    end,
  },
}

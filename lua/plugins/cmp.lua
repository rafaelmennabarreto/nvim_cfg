return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
  },

  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip          = require("luasnip")
    local cmp              = require("cmp")

    opts.mapping           = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
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
    })

    local source_names     = {
      nvim_lsp = "[LSP]",
      emoji = "[Emoji]",
      path = "[Path]",
      calc = "[Calc]",
      cmp_tabnine = "[Tabnine]",
      vsnip = "[Snippet]",
      luasnip = "[Snippet]",
      buffer = "[Buffer]",
      tmux = "[TMUX]",
      codeium = "[IA]",
    }

    local icons            = {
      Constructor = "  ",
      Function = "  ",
      Keyword = "  ",
      Method = "  ",
      Module = "  ",
      Snippet = " 󰹷 ",
      Text = " 󰟵 ",
      Variable = " 󰚇 ",
      Field = "  ",
      Property = "  ",
      Constant = "  ",
      Array = '  ',
      Boolean = '  ',
      Color = '  ',
      Enum = '  ',
      EnumMember = '  ',
      Event = '  ',
      File = '  ',
      Folder = '  ',
      Interface = '  ',
      Key = '  ',
      Namespace = '  ',
      Null = ' ﳠ ',
      Number = '  ',
      Object = '  ',
      Operator = '  ',
      Package = '  ',
      Reference = '  ',
      String = '  ',
      Struct = '  ',
      TypeParameter = '  ',
      Unit = '  ',
      Value = '  ',
      Win = '  ',
      Codeium = "  ",
      Class = "  ",
    }

    opts.window            = {
      completion = {
        border = 'rounded',
        --col_offset = -3,
        --side_padding = 0,
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
      },
      documentation = {
        border = 'rounded',
        --col_offset = -3,
        --side_padding = 0,
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
      }
      --documentation = cmp.config.window.bordered(),
    }

    opts.formatting        = {
      mode = 'symbol_text',
      fields = { "abbr", "kind", "menu" },
      expandable_indicator = true,
      max_width = 0,
      format = function(entry, vim_item)
        vim_item.dup = 1
        vim_item.abbr = string.sub(vim_item.abbr, 1, 50 - 1)
        vim_item.menu = source_names[entry.source.name]
        vim_item.kind = (icons[vim_item.kind] or vim_item.kind)

        return vim_item
      end
    }

    opts.sources           = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
  end
}

return {
  {
    {
      "folke/snacks.nvim",
      ---@type snacks.Config
      opts = {
        dashboard = {
          enabled = true,
          width = 60,
          row = nil, -- dashboard position. nil for center
          col = nil, -- dashboard position. nil for center
          pane_gap = 4, -- empty columns between vertical panes
          autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
          -- These settings are used by some built-in sections
          preset = {
            -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
            ---@type fun(cmd:string, opts:table)|nil
            pick = nil,
            -- Used by the `keys` section to show keymaps.
            -- Set your custom keymaps here.
            -- When using a function, the `items` argument are the default keymaps.
            ---@type snacks.dashboard.Item[]
            ---
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
              { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
              { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
              {
                icon = " ",
                key = "c",
                desc = "Config",
                action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
              },
              { icon = " ", key = "s", desc = "Restore Session", section = "session" },
              { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
            -- Used by the `header` section
            header = [[
  ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄  
  █  ▄    █      █   ▄  █ █   ▄  █ █       █       █       █
  █ █▄█   █  ▄   █  █ █ █ █  █ █ █ █    ▄▄▄█▄     ▄█   ▄   █
  █       █ █▄█  █   █▄▄█▄█   █▄▄█▄█   █▄▄▄  █   █ █  █ █  █
  █  ▄   ██      █    ▄▄  █    ▄▄  █    ▄▄▄█ █   █ █  █▄█  █
  █ █▄█   █  ▄   █   █  █ █   █  █ █   █▄▄▄  █   █ █       █
  █▄▄▄▄▄▄▄█▄█ █▄▄█▄▄▄█  █▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄▄▄▄▄█
]],
          },
          -- item field formatters
          formats = {
            icon = function(item)
              if item.file and item.icon == "file" or item.icon == "directory" then
                return Snacks.dashboard.icon(item.file, item.icon)
              end
              return { item.icon, width = 2, hl = "icon" }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ":~")
              fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
              if #fname > ctx.width then
                local dir = vim.fn.fnamemodify(fname, ":h")
                local file = vim.fn.fnamemodify(fname, ":t")
                if dir and file then
                  file = file:sub(-(ctx.width - #dir - 2))
                  fname = dir .. "/…" .. file
                end
              end
              local dir, file = fname:match("^(.*)/(.+)$")
              return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
            end,
          },
          sections = {
            { section = "header" },
            {
              pane = 2,
              section = "terminal",
              cmd = "colorscript -e square",
              height = 5,
              padding = 1,
            },
            { section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            {
              pane = 2,
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
              cmd = "git status --short --branch --renames",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
            { section = "startup" },
          },
        },
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    enabled = false,
    opts = function()
      local logo = [[
 ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄          ▄▄    ▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ 
█  ▄    █      █   ▄  █ █   ▄  █ █       █       █       █        █  █  █ █  █ █  █   █  █▄█  █
█ █▄█   █  ▄   █  █ █ █ █  █ █ █ █    ▄▄▄█▄     ▄█   ▄   █        █   █▄█ █  █▄█  █   █       █
█       █ █▄█  █   █▄▄█▄█   █▄▄█▄█   █▄▄▄  █   █ █  █ █  █        █       █       █   █       █
█  ▄   ██      █    ▄▄  █    ▄▄  █    ▄▄▄█ █   █ █  █▄█  █        █  ▄    █       █   █       █
█ █▄█   █  ▄   █   █  █ █   █  █ █   █▄▄▄  █   █ █       █        █ █ █   ██     ██   █ ██▄██ █
█▄▄▄▄▄▄▄█▄█ █▄▄█▄▄▄█  █▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄▄▄▄▄█        █▄█  █▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█
    ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = 'Telescope find_files',              desc = ' Find file',       icon = ' ', key = 'f' },
          { action = 'ene | startinsert',                 desc = ' New file',        icon = ' ', key = 'n' },
          { action = 'Telescope oldfiles',                desc = ' Recent files',    icon = ' ', key = 'r' },
          { action = 'Telescope live_grep',               desc = ' Find text',       icon = ' ', key = 'g' },
          { action = 'lua LazyVim.pick.config_files()()', desc = ' Config',          icon = ' ', key = 'c' },
          { action = 'lua require("persistence").load()', desc = ' Restore Session', icon = ' ', key = 's' },
          { action = 'LazyExtras',                        desc = ' Lazy Extras',     icon = ' ', key = 'x' },
          { action = 'Lazy',                              desc = ' Lazy',            icon = '󰒲 ', key = 'l' },
          { action = 'qa',                                desc = ' Quit',            icon = ' ', key = 'q' },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}

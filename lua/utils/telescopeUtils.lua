local m = {}

m.find_file = function()
  require("telescope.builtin").find_files()
end

m.find_word = function()
  require("telescope.builtin").live_grep()
end

m.grep_string = function()
  require("telescope.builtin").grep_string()
end

m.fileExplorer = function()
  local telescope = require("telescope")

  local function telescope_buffer_dir()
    return vim.fn.expand("%:p:h")
  end

  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end

m.highlight_telescope = function(hl, c)
  local prompt = c.bg
  hl.TelescopeNormal = {
    bg = c.bg,
    fg = c.fg,
  }
  hl.TelescopeBorder = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.NoiceCmdlinePopupBorder = {
    bg = c.bg,
    fg = c.bg,
  }
end

return m

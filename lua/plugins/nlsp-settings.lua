return {
  'tamago324/nlsp-settings.nvim',
  config = function()
    local _, nlspsettings = pcall(require, 'nlspsettings')

    nlspsettings.setup({
      config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
      local_settings_dir = ".nlsp-settings",
      local_settings_root_markers_fallback = { '.git' },
      append_default_schemas = true,
      loader = 'json'
    })
  end
}

local m = {}

m.get_root_dir = function()
  return vim.fn.getcwd()
end

m.get_volta_root = function ()
  return vim.fn.getenv("VOLTA_HOME")
end

return m

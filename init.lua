if vim.g.vscode then
  require("sakidoa/vscode_keymaps")
else
  if vim.loader then
    vim.loader.enable()
  end

  _G.dd = function(...)
    require("util.debug").dump(...)
  end
  vim.print = _G.dd

  require("config.lazy")
end

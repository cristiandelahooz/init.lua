-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local extras = "lazyvim.plugins.extras"

---@type LazyConfig
local M = {}

M.spec = {
  -- add LazyVim and import its plugins
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = {
      colorscheme = "solarized-osaka",
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
  -- import any extras modules here
  { import = extras .. ".lang.typescript" },
  { import = extras .. ".lang.json" },
  { import = extras .. ".lang.rust" },
  { import = extras .. ".lang.tailwind" },
  { import = extras .. ".lang.java" },
  { import = extras .. ".lang.docker" },
  { import = extras .. ".lang.git" },
  { import = extras .. ".lang.go" },
  { import = extras .. ".lang.markdown" },
  { import = extras .. ".lang.python" },
  { import = extras .. ".lang.sql" },
  { import = extras .. ".lang.tex" },
  { import = extras .. ".lang.yaml" },
  { import = extras .. ".coding.yanky" },
  { import = extras .. ".dap.core" },
  { import = extras .. ".ai.copilot-chat" },
  { import = extras .. ".editor.harpoon2" },
  { import = extras .. ".editor.inc-rename" },
  { import = extras .. ".editor.mini-files" },
  { import = extras .. ".formatting.biome" },
  { import = extras .. ".util.dot" },
  { import = extras .. ".util.mini-hipatterns" },
  { import = "plugins" },
}

M.defaults = {
  -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
  -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
  lazy = true,
  -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
  -- have outdated releases, which may break your Neovim install.
  version = false, -- always use the latest git commit
  -- version = "*", -- try installing the latest stable version for plugins that support semver
}

M.dev = {
  -- Directory where you store your local plugin projects. If a function is used,
  -- the plugin directory (e.g. `~/projects/plugin-name`) must be returned.
  path = "~/ghq/github.com/cristiandelahooz",
}

M.checker = { enabled = true } -- automatically check for plugin updates

M.performance = {
  cache = {
    enabled = true,
    -- disable_events = {},
  },
  rtp = {
    -- disable some rtp plugins
    disabled_plugins = {
      "gzip",
      -- "matchit",
      -- "matchparen",
      "netrwPlugin",
      "rplugin",
      "tarPlugin",
      "tutor",
      "zipPlugin",
    },
  },
}

M.ui = {
  custom_keys = {
    ["<localleader>d"] = function(plugin)
      dd(plugin)
    end,
  },
}

M.debug = false

require("lazy").setup(M)

return M

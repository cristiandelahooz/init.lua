local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local extras = "lazyvim.plugins.extras"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
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
		{ import = extras .. ".lang.haskell" },
		{ import = extras .. ".lang.markdown" },
		{ import = extras .. ".lang.python" },
		{ import = extras .. ".lang.sql" },
		{ import = extras .. ".lang.yaml" },
		{ import = extras .. ".dap.core" },
		{ import = extras .. ".ai.copilot-chat" },
		{ import = extras .. ".editor.harpoon2" },
		{ import = extras .. ".formatting.biome" },
		{ import = extras .. ".util.dot" },
		{ import = extras .. ".util.mini-hipatterns" },
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	dev = {
		path = "~/.ghq/github.com",
	},
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
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
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		custom_keys = {
			["<localleader>d"] = function(plugin)
				dd(plugin)
			end,
		},
	},
	debug = false,
})

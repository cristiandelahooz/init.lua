--[[
  ============================================================
  Author: Cristian de la Hoz (GitHub: cristiandelahooz)
  Alias: sakidoa (For fun)
  
  Copyright (C) 2025 - All Rights Reserved
  This file contains general-purpose functions for custom keymaps.
  These functions are designed to be used across various filetypes for enhanced productivity and convenience.
  
  Feel free to fork, modify, and share, but please give credit where it's due.
  ============================================================
]]

local M = {}

--[[
  Executes the current file based on its filetype.
  Supported filetypes include JavaScript, TypeScript, C, Go, Zsh, Bash, Haskell, Java, and React variants.
  Opens a new tab with a terminal to run the command.
]]
function M.RunCurrentFile()
	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%:p") -- Use absolute path for safety
	local escaped_filename = vim.fn.shellescape(filename) -- Cache shellescaped filename
	local output_file = "output"

	-- Define commands for each filetype
	local commands = {
		javascript = "node " .. escaped_filename,
		typescript = "tsx " .. escaped_filename,
		c = string.format("gcc %s -o %s && ./%s && rm %s", escaped_filename, output_file, output_file, output_file),
		go = "go run " .. escaped_filename,
		zsh = "./" .. escaped_filename,
		bash = "./" .. escaped_filename,
		haskell = string.format(
			"ghc %s -o %s && ./%s && rm -f ./*{.o,.hi,%s}",
			escaped_filename,
			output_file,
			output_file,
			output_file
		),
		java = "gd run",
		typescriptreact = "tsx " .. escaped_filename,
		javascriptreact = "node " .. escaped_filename,
	}

	-- Execute the command if available for the filetype
	if commands[filetype] then
		vim.cmd(":tabnew | term " .. commands[filetype]) -- Run program
	else
		vim.notify("No execution command set for filetype: " .. filetype, vim.log.levels.WARN)
	end
end

return M

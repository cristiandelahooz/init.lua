local augroup = vim.api.nvim_create_augroup
local delahozGroup = augroup("delahoz", {})
local autocmd = vim.api.nvim_create_autocmd

-- Turn off paste mode when leaving insert
--[[autocmd("InsertLeave", {
	group = delahozGroup,
	pattern = "*",
	command = "set nopaste",
})]]

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
autocmd("FileType", {
	group = delahozGroup,
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

autocmd("BufRead", {
	group = delahozGroup,
	pattern = "*.conf",
	command = "set filetype=apache",
})

autocmd("LspAttach", {
	group = delahozGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- exit insert mode
keymap.set("i", "qj", "<Esc>:w<CR>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("craftzdog.lsp").toggleInlayHints()
end)

vim.api.nvim_create_user_command("ToggleAutoformat", function()
	require("craftzdog.lsp").toggleAutoformat()
end, {})

--[[ 
    Run the current file based on the filetype
    Supported filetypes:
    - javascript
    - typescript
    - c
    - go
    - zsh
    - bash
    - haskell
    - java
]]
function RunCurrentFile()
	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%")
	local output_file = "output"

	local commands = {
		javascript = "node " .. filename,
		typescript = "tsx " .. filename,
		c = "gcc " .. filename .. " -o " .. output_file .. " && ./" .. output_file .. " && rm " .. output_file,
		go = "go run " .. filename,
		zsh = "./" .. filename,
		bash = "./" .. filename,
		haskell = "ghc " .. filename .. " -o " .. output_file .. "&& ./" .. output_file .. "&& rm ./*{.o,.hi,output}",
		java = "gd run",
	}

	if commands[filetype] then
		vim.cmd(":term " .. commands[filetype]) -- Run program
	else
		print("No execution command set for filetype: " .. filetype)
	end
end

vim.api.nvim_set_keymap("n", "<leader>r", ":lua RunCurrentFile()<CR>", opts)

local function set_keymaps_for_ft()
	local ft = vim.bo.filetype

	if ft == "java" then
		-- Manejo de excepciones en Java
		vim.keymap.set(
			"n",
			"<leader>ee",
			"otry {<CR>} catch (Exception e) {<CR>throw new RuntimeException(e);<CR>}<Esc>O",
			{ buffer = true }
		)
		vim.keymap.set(
			"n",
			"<leader>el",
			'otry {<CR>} catch (Exception e) {<CR>logger.severe("Error: " + e.getMessage());<CR>}<Esc>O',
			{ buffer = true }
		)
		vim.keymap.set("n", "<leader>ea", 'oassert condition : "Error: " + e.getMessage();<Esc>F";a', { buffer = true })
		vim.keymap.set(
			"n",
			"<leader>ef",
			'otry {<CR>} catch (Exception e) {<CR>System.err.println("Error: " + e.getMessage());<CR>}<Esc>O',
			{ buffer = true }
		)
	elseif ft == "go" then
		-- Manejo de errores en Go
		vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { buffer = true })
		vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a', { buffer = true })
		vim.keymap.set(
			"n",
			"<leader>ef",
			'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj',
			{ buffer = true }
		)
		vim.keymap.set(
			"n",
			"<leader>el",
			'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i',
			{ buffer = true }
		)
	end
end

-- Execute when open a buffer
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = set_keymaps_for_ft,
})

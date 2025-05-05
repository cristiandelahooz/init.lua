local discipline = require("sakidoa.discipline")

local functions = require("sakidoa.keymaps_functions")
discipline.cowboy()

local keymap = require("util.helper_functions").keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap("n", "x", '"_x', opts, "Delete without yanking")
keymap("n", "<Leader>p", '"0p', opts, "Paste from yank register")
keymap("n", "<Leader>P", '"0P', opts, "Paste before from yank register")
keymap("v", "<Leader>p", '"0p', opts, "Paste from yank register in visual mode")
keymap("n", "<Leader>c", '"_c', opts, "Change without yanking")
keymap("n", "<Leader>C", '"_C', opts, "Change to end of line without yanking")
keymap("v", "<Leader>c", '"_c', opts, "Change selection without yanking")
keymap("v", "<Leader>C", '"_C', opts, "Change selection to end of line without yanking")
keymap("n", "<Leader>d", '"_d', opts, "Delete without yanking")
keymap("n", "<Leader>D", '"_D', opts, "Delete to end of line without yanking")
keymap("v", "<Leader>d", '"_d', opts, "Delete selection without yanking")
keymap("v", "<Leader>D", '"_D', opts, "Delete selection to end of line without yanking")


--Disable copilot
keymap("i", "<C-e>", function()
  vim.cmd("Copilot disable")
  vim.notify("Copilot desactivado", vim.log.levels.INFO)
end, opts, "Disable copilot")
-- Center screen while scrolling
keymap({ "n", "v" }, "<C-u>", "<C-u>zz", opts, "Scroll up and center")
keymap({ "n", "v" }, "<C-d>", "<C-d>zz", opts, "Scroll down and center")

-- Exit all
keymap("n", "Q", [[:qall<CR>]], opts, "Quit all")

-- Increment/decrement
keymap("n", "+", "<C-a>", opts, "Increment number")
keymap("n", "-", "<C-x>", opts, "Decrement number")

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts, "Select all")

-- Search and replace
keymap("n", "<leader>s", [[:%s/<C-r><C-w>]], opts, "Search and replace word under cursor")

-- Move selected line/block of text in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts, "Move selection down")
keymap("v", "K", ":m '<-2<CR>gv=gv", opts, "Move selection up")

-- Join lines without moving cursor
keymap("n", "J", "mzJ`z", opts, "Join lines without moving cursor")

-- Paste without yanking
keymap("x", "<leader>p", [["_dP]], opts, "Paste without yanking")

-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", [["+y]], opts, "Yank to system clipboard")
keymap({ "n", "v" }, "<leader>Y", [["+yg_]], opts, "Yank line to system clipboard")

-- Tmux-sessionizer controller
keymap("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts, "Open Tmux sessionizer")
keymap("n", "<C-g>", "<cmd>silent !ide<CR>", opts, "Open IDE")

-- Disable continuations
keymap("n", "<Leader>o", "o<Esc>^Da", opts, "Insert line below without continuation")
keymap("n", "<Leader>O", "O<Esc>^Da", opts, "Insert line above without continuation")

-- Exit insert mode with Ctrl+C
keymap("i", "<C-c>", "<Esc>", opts, "Exit insert mode")

-- Jumplist
keymap("n", "<C-m>", "<C-i>", opts, "Go forward in jumplist")

-- Tab management
keymap("n", "te", ":tabedit", opts, "Open new tab")
keymap("n", "<tab>", ":tabnext<Return>", opts, "Go to next tab")
keymap("n", "<s-tab>", ":tabprev<Return>", opts, "Go to previous tab")

-- Split window
keymap("n", "ss", ":split<Return>", opts, "Split window horizontally")
keymap("n", "sv", ":vsplit<Return>", opts, "Split window vertically")

-- Move between windows
keymap("n", "sh", "<C-w>h", opts, "Move to left window")
keymap("n", "sk", "<C-w>k", opts, "Move to upper window")
keymap("n", "sj", "<C-w>j", opts, "Move to lower window")
keymap("n", "sl", "<C-w>l", opts, "Move to right window")

-- Resize window
keymap("n", "<C-w><left>", "<C-w><", opts, "Resize window left")
keymap("n", "<C-w><right>", "<C-w>>", opts, "Resize window right")
keymap("n", "<C-w><up>", "<C-w>+", opts, "Resize window up")
keymap("n", "<C-w><down>", "<C-w>-", opts, "Resize window down")

-- keymaps that use functions
keymap("n", "<leader>r", functions.RunCurrentFile, opts, "Run current file")

vim.api.nvim_create_user_command("ToggleInlayHints", function()
  require("sakidoa.lsp").toggleInlayHints()
end, {})

vim.api.nvim_create_user_command("ToggleAutoformat", function()
  require("sakidoa.lsp").toggleAutoformat()
end, {})

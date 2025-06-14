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

-- Configuración de lazy.nvim
require("lazy").setup({
  { "kylechui/nvim-surround", version = "*", opts = {} },
  {
    "gbprod/yanky.nvim",
    opts = {
      ring = {
        history_length = 100, -- Máximo número de yanks en el historial
        storage = "shada", -- Usar shada en lugar de SQLite para persistencia
        sync_with_numbered_registers = true, -- Sincronizar con registros numerados
      },
      system_clipboard = {
        sync_with_ring = true, -- Sincronizar el clipboard del sistema con el historial
      },
    },
    keys = {
      { ";y", "<cmd>YankyRingHistory<cr>", mode = { "n", "v" }, desc = "Open yank history with Telescope" },
    },
  },
  -- Añadir vim-textobj-entire
  {
    "kana/vim-textobj-entire",
    dependencies = { "kana/vim-textobj-user" },
    event = "VeryLazy", -- Carga diferida para mejorar el rendimiento
  },
  -- Añadir vim-highlightedyank
  {
    "machakann/vim-highlightedyank",
    event = "TextYankPost", -- Carga cuando se realiza un yank
    init = function()
      -- Configuración opcional: ajustar la duración del resaltado (en milisegundos)
      vim.g.highlightedyank_highlight_duration = 100
      vim.g.highlightedyank_highlight_color = "rgba(239, 68, 68, 0.3)"
    end,
  },
})

-- Función auxiliar para keymaps (reemplazo de util.helper_functions)
local function keymap(mode, lhs, rhs, opts, desc)
  opts = opts or { noremap = true, silent = true }
  if desc then
    opts.desc = desc
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Configuración específica para VS Code
-- I kow is redundant
-- Deshabilitar ; predeterminado para evitar conflictos
vim.keymap.set("n", ";", "<Nop>", { noremap = true, silent = true })

-- Keymaps específicos para VS Code
if vim.g.vscode then
  -- Disable default ';' to avoid conflicts
  vim.keymap.set("n", ";", "<Nop>", { noremap = true, silent = true })

  local vscode_actions = {
    { { "n", "v" }, "<c-/>", "workbench.action.terminal.toggleTerminal", "Toggle terminal" },
    { { "n", "v" }, "<leader>b", "editor.debug.action.toggleBreakpoint", "Toggle breakpoint" },
    { { "n", "v" }, "K", "editor.action.showHover", "Show hover" },
    { { "n", "v" }, "<leader>ca", "editor.action.quickFix", "Quick fix" },
    { { "n", "v" }, ";e", "workbench.actions.view.problems", "Show problems" },
    { { "n", "v" }, ";f", "workbench.action.quickOpen", "Quick open" },
    { { "n", "v" }, ";;", "workbench.action.showCommands", "Show commands" },
    { { "n", "v" }, "<leader>pr", "code-runner.run", "Run code" },
    { { "n", "v" }, "<leader>f", "editor.action.formatDocument", "Format document" },
    { "n", "sv", "workbench.action.splitEditor", "Split window horizontally" },
    { "n", "sh", "workbench.action.focusLeftGroup", "Move to left window" },
    { "n", "sl", "workbench.action.focusRightGroup", "Move to right window" },
    { "n", ";m", "workbench.action.toggleMaximizeEditorGroup", "Toggle Maximize window" },
    { "n", ";z", "workbench.action.toggleZenMode", "Toggle zen mode" },
  }

  for _, map in ipairs(vscode_actions) do
    keymap(map[1], map[2], "<cmd>lua require('vscode').action('" .. map[3] .. "')<CR>", nil, map[4])
  end
end

-- Configuración general de Neovim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps generales
keymap("n", "<Space>", "", nil, "Disable space")
keymap("n", "x", '"_x', nil, "Delete without yanking")
keymap("n", "<Leader>c", '"_c', nil, "Change without yanking")
keymap("n", "<Leader>C", '"_C', nil, "Change to end of line without yanking")
keymap("v", "<Leader>c", '"_c', nil, "Change selection without yanking")
keymap("v", "<Leader>C", '"_C', nil, "Change selection to end of line without yanking")
keymap("n", "<Leader>d", '"_d', nil, "Delete without yanking")
keymap("n", "<Leader>D", '"_D', nil, "Delete to end of line without yanking")
keymap("v", "<Leader>d", '"_d', nil, "Delete selection without yanking")
keymap("v", "<Leader>D", '"_D', nil, "Delete selection to end of line without yanking")
keymap({ "n", "v" }, "<C-u>", "<C-u>zz", nil, "Scroll up and center")
keymap({ "n", "v" }, "<C-d>", "<C-d>zz", nil, "Scroll down and center")
keymap("n", "Q", ":qall<CR>", nil, "Quit all")
keymap("n", "+", "<C-a>", nil, "Increment number")
keymap("n", "-", "<C-x>", nil, "Decrement number")
keymap("n", "<C-a>", "gg<S-v>G", nil, "Select all")
keymap("n", "<leader>s", ":%s/<C-r><C-w>", nil, "Search and replace word under cursor")
keymap("n", "J", "mzJ`z", nil, "Join lines without moving cursor")
keymap({ "n", "v" }, "<leader>y", [["+y]], nil, "Yank to system clipboard")
keymap({ "n", "v" }, "<leader>Y", [["+yg_]], nil, "Yank line to system clipboard")
keymap("n", "<Leader>o", "o<Esc>^Da", nil, "Insert line below without continuation")
keymap("n", "<Leader>O", "O<Esc>^Da", nil, "Insert line above without continuation")
keymap("n", "<C-m>", "<C-i>", nil, "Go forward in jumplist")
keymap("n", "<tab>", ":tabnext<CR>", nil, "Go to next tab")
keymap("n", "<s-tab>", ":tabprev<CR>", nil, "Go to previous tab")
keymap("n", "<C-w><left>", "<C-w><", nil, "Resize window left")
keymap("n", "<C-w><right>", "<C-w>>", nil, "Resize window right")
keymap("n", "<C-w><up>", "<C-w>+", nil, "Resize window up")
keymap("n", "<C-w><down>", "<C-w>-", nil, "Resize window down")
keymap("v", "<", "<gv", nil, "Indent left")
keymap("v", ">", ">gv", nil, "Indent right")
keymap("v", "J", ":m .+1<CR>==", nil, "Move text down")
keymap("v", "K", ":m .-2<CR>==", nil, "Move text up")
keymap("x", "J", ":move '>+1<CR>gv-gv", nil, "Move text down")
keymap("x", "K", ":move '<-2<CR>gv-gv", nil, "Move text up")
keymap({ "n", "v", "i" }, "<C-c>", "<Esc>", nil, "Escape")
keymap("v", "p", '"_dP', nil, "Paste without yanking")
keymap("n", "<Esc>", "<Esc>:noh<CR>", nil, "Clear search highlight")

local augroup = vim.api.nvim_create_augroup
local delahozGroup = augroup("delahoz", {})
local autocmd = vim.api.nvim_create_autocmd
local keymap = require("util.helper_functions").keymap

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
    keymap("n", "<leader>f", function()
      require("conform").format({ bufnr = 0 })
    end, opts, "Format current buffer")
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts, "Rename symbol under cursor")
    keymap("n", "]d", vim.diagnostic.get_next, opts, "Go to next diagnostic")
    keymap("n", "[d", vim.diagnostic.get_prev, opts, "Go to previous diagnostic")
  end,
})

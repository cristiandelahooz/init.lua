local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local keymap = require("util.helper_functions").keymap
local delahozGroup = augroup("delahoz", {})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
autocmd("FileType", {
  group = delahozGroup,
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

autocmd("LspAttach", {
  group = delahozGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    local function jump_diagnostic(direction)
      return function()
        vim.diagnostic.jump({ count = direction, float = true })
      end
    end
    keymap("n", "<leader>f", function()
      require("conform").format({ bufnr = 0 })
    end, opts, "Format current buffer")
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts, "Rename symbol under cursor")
    keymap("n", "]d", jump_diagnostic(1), opts, "Go to next diagnostic")
    keymap("n", "[d", jump_diagnostic(-1), opts, "Go to previous diagnostic")
  end,
})

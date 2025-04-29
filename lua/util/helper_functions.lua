local M = {}

-- Helper function to set keymaps with default options and description
M.keymap = function(mode, lhs, rhs, opts, description)
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  opts.desc = description or "No description provided"
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M

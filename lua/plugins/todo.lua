return {
  {
    "todo.nvim",
    dev = true,
    -- Load lazily to test performance
    event = "VeryLazy",
    config = function()
      require("todo").setup({})
    end,
    keys = {
      { "<leader>t", "<cmd>TodoOpen<cr>", desc = "Open Todo List" },
    },
  },
}

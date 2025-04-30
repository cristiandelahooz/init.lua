return {
  {
    dir = "~/ghq/github.com/cristiandelahooz/todo.nvim",
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

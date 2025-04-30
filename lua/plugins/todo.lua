return {
  {
    dir = "~/ghq/github.com/cristiandelahooz/todo.nvim",
    -- Load lazily to test performance
    event = "VeryLazy",
    config = function()
      require("todo").setup({
        -- Custom state directory for testing
        state_dir = vim.fn.expand("~/.todo-nvim-test/state"),
        -- Custom todo file for testing
        todo_file = vim.fn.expand("~/.todo-nvim-test/todo/todos.json"),
        -- Short auto-deletion time for testing (10 seconds)
        auto_delete_ms = 10 * 1000,
        -- Optional: Override colors for testing
        colors = {
          orange = "#f97316", -- TailwindCSS orange-500
          yellow = "#b58900",
          green = "#859900",
          base0 = "#839496",
          base03 = "#002b36",
        },
        -- Enable debug logging for development
        debug = false,
      })
    end,
    keys = {
      { "<leader>t", "<cmd>TodoOpen<cr>", desc = "Open Todo List" },
    },
  },
}

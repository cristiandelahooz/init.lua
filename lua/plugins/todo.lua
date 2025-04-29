return {
	{
		dir = "~/ghq/github.com/cristiandelahooz/todo.nvim",
		lazy = false,
		config = function()
			require("todo").setup()
		end,
		keys = {
			{ "<leader>t", "<cmd>TodoOpen<cr>", desc = "Open Todo List" },
		},
	},
}

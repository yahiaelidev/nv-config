return {
	{
		"Norminette",
		dir = vim.fn.stdpath("config") .. "/lua/custom/norminette/",
		ft = { "c", "h" },
		opts = {
		},
		keys = {
			{
				"<leader>nr",
				function() require("custom.norminette").run() end,
				desc = "Norminette: Run"
			},
		},
	},
}

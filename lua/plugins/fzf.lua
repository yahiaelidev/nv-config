return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		local set = vim.keymap.set

		fzf.setup({
			-- files = {
			-- 	find_opts = "-type f \\! -path",
			-- },
		})

		vim.cmd("FzfLua register_ui_select")
		set("n", "<leader>sm", function()
			fzf.manpages()
		end)
		set("n", "<leader>sb", function()
			fzf.buffers()
		end)
		set("n", "<leader>sf", function()
			fzf.files()
		end)
		set("n", "<leader>ch", function()
			fzf.command_history()
		end)
		set("n", "<leader>sh", function()
			fzf.helptags()
		end)
		set("n", "<leader>sn", function()
			fzf.files({ cwd = "~/.config/nvim/" })
		end)
	end,
}

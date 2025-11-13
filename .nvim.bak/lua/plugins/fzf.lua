return {

	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local fzf = require('fzf-lua')

		fzf.setup({
			-- files = {
			-- 	find_opts = "-type f \\! -path",
			-- },
		})

		vim.cmd('FzfLua register_ui_select')
		vim.keymap.set("n", "<leader>sm", function() fzf.manpages() end )
		vim.keymap.set("n", "<leader>sb", function() fzf.buffers() end )
		vim.keymap.set("n", "<leader>sf", function() fzf.files() end )
		vim.keymap.set("n", "<leader>sh", function() fzf.helptags() end )
		vim.keymap.set("n", "<leader>sn", function() fzf.files({ cwd="~/.config/nvim/" }) end)
	end,
}

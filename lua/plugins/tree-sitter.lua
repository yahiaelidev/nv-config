return {
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	main = "nvim-treesitter.configs",

	-- stylua: ignore start
	opts = {
		ensure_installed = { "bash", "c", "diff", "html",
			"lua", "luadoc", "markdown", "markdown_inline",
			"query", "vim", "vimdoc", },

		sync_install = false,
		auto_install = true,

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Enter>",
				node_incremental = "<Enter>",
				scope_incremental = "grc",
				node_decremental = "<Backspace>",
			},
		},

		indent = { enable = true },
	},
	-- stylua: ignore end
}

return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				"lazy.nvim",
			},
			enabled = true,
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}

return {
	"fredrikaverpil/godoc.nvim",
	version = "*",
	dependencies = {
		{
			"ibhagwan/fzf-lua",
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "go" },
			},
		},
	},
	build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
	cmd = { "GoDoc" },
	opts = {
		picker = {
			type = "fzf_lua",
		},
	},
}

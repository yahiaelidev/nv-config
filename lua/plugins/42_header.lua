return {
	"Diogo-ss/42-header.nvim",
	cmd = { "Stdheader" },
	keys = { "<F1>" },
	opts = {
		default_map = true,         -- Default mapping <F1> in normal mode.
		auto_update = false,        -- Update header when saving.
		user = "yahiaelidev",       -- Your user.
		mail = "yahiaelid@yahia.com", -- Your mail.
	},
	config = function(_, opts)
		require("42header").setup(opts)
	end,
}

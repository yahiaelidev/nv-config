vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require("config.lazy")
require("config.options")
require("config.defaults")
require("config.keymaps")
require("config.c-term")
require("config.autocmds")

vim.diagnostic.config({
	virtual_text = true,
	underline = false,
	severity_sort = true,
	update_in_insert = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "none",
		source = "if_many",
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
})

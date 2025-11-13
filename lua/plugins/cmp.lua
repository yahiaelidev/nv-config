return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},

	version = "1.*",

	---@module 'blink.cmp'
	---@diagnostic disable-next-line: undefined-doc-name
	---@type blink.cmp.Config

	config = function()
		require("blink.cmp").setup({
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },

			completion = {
				ghost_text = {
					enabled = false,
					show_with_selection = true,
					show_without_selection = true,
					show_with_menu = true,
					show_without_menu = true,
				},
				menu = {
					border = nil,
					scrolloff = 1,
					min_width = 10,
					max_height = 5,
					auto_show = true,
					scrollbar = false,
					draw = {
						columns = {
							{
								"label",
								"label_description",
								gap = 1,
							},
							{ "kind" },
							{ "kind_icon",  gap = 1 },
							{ "source_name" },
						},
					},
				},
				documentation = {
					window = {
						border = nil,
						scrollbar = false,
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					},
					auto_show = false,
					auto_show_delay_ms = 500,
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			sources = {
				default = { "lsp", "buffer", "snippets", "path" },
			},
		})
	end,
}

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
		require("luasnip.loaders.from_vscode").lazy_load()
		require("blink.cmp").setup({

			snippets = { preset = "luasnip" },
			appearance = { nerd_font_variant = "mono" },

			-- keymap = {
			-- 	preset = "default",
			-- 	["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
			-- },
			--
			-- cmdline = {
			-- 	keymap = {
			-- 		["<Up>"] = { "select_prev", "fallback" },
			-- 		["<Down>"] = { "select_next", "fallback" },
			--
			-- 		["<C-p>"] = { "select_prev", "fallback" },
			-- 		["<C-n>"] = { "select_next", "fallback" },
			-- 	},
			-- },

			completion = {
				trigger = {
					prefetch_on_insert = true,
				},

				list = {
					selection = {
						auto_insert = true,
					},
				},

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
					max_height = 15,
					auto_show = true,
					scrollbar = false,
					draw = {

						columns = {
							{ "kind_icon",  gap = 1 },
							{
								"label",
								"label_description",
								gap = 1,
							},
							{ "kind" },
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

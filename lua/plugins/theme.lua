return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
			})
			vim.cmd.colorscheme('tokyonight-moon')
		end
	},
	{ -- Catppuccin
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = true,
		priority = 1000,
		config = function()
			local custom_hl = require("custom.colors")

			require("catppuccin").setup({
				transparent_background = false,
				auto_integrations = true,
				styles = {
					comments = { "italic" },
					-- conditionals = { "italic" },
					-- functions = { "italic" },
				},
				custom_highlights = function(colors)
					local hl = {}
					local c = custom_hl.highlights(colors)

					for k, v in pairs(c) do
						hl[k] = v
					end

					return hl
				end,
			})
			vim.cmd.colorscheme("catppuccin-mocha")
			vim.cmd(":hi statusline guibg=NONE")
		end,
	},
	-- Addons
	{ -- Hlchunk
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					use_treesitter = true,
					notify = false,
					style = {
						{ fg = "#8071f4" },
					},
					duration = 100,
					delay = 0,
				},
				indent = {
					enable = true,
					chars = { "│" },
					style = { "#2d3149" },
				}
			})
		end
	},
	{ -- Todo-comments
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				DONE = { icon = " ", color = "hint" },
				TODO = { icon = "□ ", color = "info" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		}
	},
}

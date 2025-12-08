return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = true,
		priority = 1000,
		config = function()
			local lang_hl = require("custom.colors")

			require("catppuccin").setup({
				integrations = {
					fidget = true,
					oil = true,
					fzf = true,
					blink = true,
				},

				custom_highlights = function(colors)
					local hl = {}
					local custom = lang_hl.highlights(colors)

					for k, v in pairs(custom) do
						hl[k] = v
					end

					return hl
				end,
			})
			vim.cmd.colorscheme("catppuccin-mocha")
			-- vim.cmd(":hi statusline guibg=NONE")
		end,
	},
	{
		"rose-pine/neovim",
		enabled = false,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({

				variant = "main",
				extend_background_behind_borders = true,
				disable_background = false,
				dim_inactive_windows = false,
				palette = {
					main = {
						rose = "#ea9a97",
						comment = "#6e6a86",
						pine = "#3e8fb0",
					},
				},

				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
				highlight_groups = {
					Comment = { fg = "comment" },
					VertSplit = { fg = "muted", bg = "muted" },
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}

-- return {
-- }

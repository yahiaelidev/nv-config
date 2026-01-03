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
			vim.cmd(":hi statusline guibg=NONE")
		end,
	},
	{
		"itchyny/lightline.vim",
		enabled = false,
		config = function()
			vim.g.lightline = {
				["colorscheme"] = "catppuccin",
			}
		end,
	},
}

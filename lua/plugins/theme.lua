return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local lang_hl = require("custom.colors")

		require("catppuccin").setup({
			integrations = {
				fidget = true,
				oil = true,
				fzf = true,
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
	end,
}

-- return {
-- 	'rose-pine/neovim',
-- 	enabled = true,
-- 	name = 'rose-pine',
-- 	config = function()
-- 		require('rose-pine').setup {
--
-- 			variant = 'dawn',
-- 			dim_inactive_windows = true,
-- 			palette = {
-- 				main = {
-- 					rose = "#ea9a97",
-- 					comment = '#6e6a86',
-- 					pine = "#3e8fb0"
-- 				},
-- 			},
-- 			highlight_groups = {
-- 				Comment = { fg = 'comment' },
-- 				VertSplit = { fg = "muted", bg = "muted" },
-- 			},
-- 		}
-- 		vim.cmd 'colorscheme rose-pine'
-- 		vim.cmd(":hi statusline guibg=NONE")
-- 	end,
-- }

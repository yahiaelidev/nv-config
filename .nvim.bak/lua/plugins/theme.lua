return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{"blazkowolf/gruber-darker.nvim"},
	{
		'Everblush/nvim',
		pritority = 100000;
		name = 'everblush',
		opts = {
		},
		config = function()
			require('everblush').setup({
				transparent_background = true,
				nvim_tree = {
					contrast = true,
				},
			})
			vim.cmd('colorscheme everblush')
			-- vim.cmd(":hi statusline guibg=NONE")
			-- vim.cmd(":hi LineNR guifg=#808080")
			-- vim.cmd(":hi StatuslineNC guifg=#808080")
		end
	},
	{
		'deparr/tairiki.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,

		},

	},
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

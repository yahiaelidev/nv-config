return {
	lazy = false,
	'stevearc/oil.nvim',

	---@module 'oil'
	---@diagnostic disable-next-line: undefined-doc-name
	---@type oil.SetupOpts

	opts = {
		float = {
			get_win_title = nil,
			preview_split = "right",

			padding = 0,
			max_width = 0.5,
			max_height = 0.5,
			border = "rounded",

			show_hidden = true,

			win_options = {
				winblend = 0,
			},

			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,

			override = function(conf)
				return conf
			end,

			is_always_hidden = function(fs, _)
				return fs == '..' or fs == '.git'
			end
		},
		vim.keymap.set('n', '-', '<CMD>Oil --float<CR>'),
	},
}

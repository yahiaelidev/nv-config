return {
	"stevearc/conform.nvim",
	config = function()
		local formatters_by_ft = {}
		local conform = require("conform")
		local c42 = { 'c', 'hpp', 'cpp', 'h', }

		for _, ft in ipairs(c42) do
			formatters_by_ft[ft] = { "c_formatter_42" }
		end

		conform.setup({
			formatters_by_ft = formatters_by_ft,

			formatters = {
				c_formatter_42 = {
					command = "c_formatter_42",
					stdin = true,
				},
			},

			format_on_save = function(bufnr)
				local disable_filetypes = {
					c = false,
					h = false,
					hpp = false,
					cpp = false,
					cuda = true,
					objc = true,
				}

				if disable_filetypes[vim.bo[bufnr].filetype] then
					return
				end

				return {
					bufnr = bufnr,
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
		})
	end,
}

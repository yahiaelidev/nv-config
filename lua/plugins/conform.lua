return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				c = { "c_formatter_42" },
				h = { "c_formatter_42" },
			},

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
					-- hpp = true,
					-- cpp = true,
					-- cuda = true,
					-- objc = true,
				}

				if disable_filetypes[vim.bo[bufnr].filetype] then
					return
				end

				return {
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
		})
	end,
}

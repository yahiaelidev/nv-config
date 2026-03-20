return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		local formatters_by_ft = {}

		local formatters = {
			c_formatter_42 = { 'c', 'hpp', 'cpp', 'h', },
			prettierd = {
				'javascript',
				'javascriptreact',
				'typescript',
				'typescriptreact',
				"css",
				"html",
				"astro",
				"json",
				"yaml",
				"markdown"
			}
		}

		for formatter, fileTypes in pairs(formatters) do
			for _, ft in ipairs(fileTypes) do
				formatters_by_ft[ft] = { formatter }
			end
		end

		conform.setup({
			log_level = vim.log.levels.WARN,
			formatters_by_ft = formatters_by_ft,

			formatters = {
				c_formatter_42 = {
					command = "c_formatter_42",
					stdin = true,
				},
			},

			format_on_save = function(bufnr)
				local disable_filetypes = {
					c = true,
					h = true,
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
					timeout_ms = 1000,
					lsp_fallback = true,
				}
			end,
		})
	end,
}

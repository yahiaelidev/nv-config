return {
	'stevearc/conform.nvim',
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {

				lua = { "stylua" },

				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					end
				end
			},

			format_on_save = function(bufnr)
				local dis_ft = {
					c = true,
					h = true,
				}

				local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
				if dis_ft[ft] then
					return
				end

				return { timeout_ms = 500, lsp_fallback = true }
			end
		})
	end
}

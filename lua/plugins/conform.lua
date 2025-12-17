return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")

		conform.setup({
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

				conform.format({ bufnr = bufnr, lsp_fallback = true })
			end,
		})
	end,
}

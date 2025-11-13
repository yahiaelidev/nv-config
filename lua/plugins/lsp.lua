---@diagnostic disable: undefined-global
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"j-hui/fidget.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	lazy = false,
	config = function()
		require("mason").setup()
		require("fidget").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = { "clangd", "lua_ls" },
		})

		local allcapabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(allcapabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		vim.lsp.config("clangd", {
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--clang-tidy",
				"--background-index",
				"--header-insertion=iwyu",
				"--all-scopes-completion",
				"--completion-parse=auto",
				"--completion-style=bundled",
				"--suggest-missing-includes",
				"--query-driver=/usr/bin/cc*",
			},
			filetypes = { "c", "h" },
			init_options = {
				usePlaceholders = true,
				clangdFileStatus = true,
				completeUnimported = true,
				fallbackFlags = { "-Wall", "-Wextra", "-Werror" },
			},
		})
		vim.lsp.enable("clangd")

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					format = { enable = true },
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
			underline = false,
			severity_sort = true,
			update_in_insert = false,
			float = {
				focusable = false,
				style = "minimal",
				border = "none",
				source = "if_many",
				header = "",
				prefix = "",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "»",
				},
			},
		})
	end,
}

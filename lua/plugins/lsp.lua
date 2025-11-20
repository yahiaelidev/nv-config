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
			ensure_installed = { "lua_ls" },
			automatic_installation = false,
		})

		local allcapabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(allcapabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		vim.lsp.config("clangd", {
			capabilities = capabilities,
			cmd = {
				"clangd-20",
				"--clang-tidy",
				"--background-index",
				"--header-insertion=iwyu",
				"--all-scopes-completion",
				"--completion-style=bundled",
				"--suggest-missing-includes",
				"--query-driver=/usr/bin/cc,/usr/bin/clang,/usr/bin/gcc",
				"--compile-commands-dir=" .. vim.fn.getcwd(),
			},
			filetypes = { "c", "h" },
			init_options = {
				usePlaceholders = true,
				clangdFileStatus = true,
				completeUnimported = true,
				fallbackFlags = {
					"-Wall",
					"-Wextra",
					"-Werror",
					-- "-I/usr/include",
					-- "-I/usr/include/x86_64-linux-gnu",
					-- "-D_GNU_SOURCE",
				},
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

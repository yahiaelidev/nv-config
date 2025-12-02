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
			ensure_installed = {
				"lua_ls",
				"bashls",
				"gopls",
			},
			automatic_installation = false,
		})

		local allcapabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(allcapabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local servers = {

			gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
				root_markers = { "go.mod", "go.work", ".git" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			},

			clangd = {
				cmd = {
					"clangd-20",
					"--clang-tidy",
					"--background-index",
					"--header-insertion=iwyu",
					"--all-scopes-completion",
					"--completion-style=bundled",
					"--suggest-missing-includes",
					"--query-driver=/usr/bin/clang",
					"--compile-commands-dir=" .. vim.fn.getcwd(),
				},
				filetypes = { "c", "h", "hpp", "cpp", "objc", "objcpp", "cuda" },
				init_options = {
					usePlaceholders = true,
					clangdFileStatus = true,
					completeUnimported = true,
					fallbackFlags = {
						"-Wall",
						"-Wextra",
						"-Werror",
						"-I/usr/include",
						"-I/usr/include/x86_64-linux-gnu",
						"-D_GNU_SOURCE",
					},
				},
			},

			lua_ls = {
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
			},

			bashls = {
				filetypes = { "sh", "bash", "zsh", "shell" },
			},
		}

		for srv, conf in pairs(servers) do
			vim.lsp.config(
				srv,
				vim.tbl_extend("force", {
					capabilities = capabilities,
				}, conf)
			)
			vim.lsp.enable(srv)
		end

		vim.diagnostic.config({
			virtual_text = true,
			underline = false,
			severity_sort = true,
			update_in_insert = false,
			float = {
				focusable = false,
				style = "minimal",
				border = "none",
				source = false,
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "»",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.WARN] = "WarningMsg",
				},
			},
		})

		vim.keymap.set("n", "<leader>a", vim.diagnostic.open_float, {
			desc = "Show diagnostic details",
		})
	end,
}

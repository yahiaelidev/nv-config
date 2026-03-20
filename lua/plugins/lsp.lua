---@diagnostic disable: undefined-global
-- TODO : Fix Active LSP Client on closed buffers
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
				"gopls", "lua_ls", "bashls",
				"html", "astro", "cssls", "tailwindcss",
				"ts_ls", "eslint",
				-- "emmet_ls",
			},
			automatic_installation = false,
		})

		local allcapabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(allcapabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.workspace.semanticTokens = nil

		local servers = {

			astro = {},
			cssls = {},
			html = { filetypes = { "html" } },
			-- emmet_ls = {
			-- 	filetypes = {
			-- 		"html", "css", "sass", "scss",
			-- 	},
			-- },

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
					"--header-insertion=never",
					"--all-scopes-completion",
					"--completion-style=bundled",
					"--suggest-missing-includes",
					"--query-driver=/usr/bin/clang",
					"--compile-commands-dir=" .. vim.fn.getcwd(),
				},
				filetypes = {
					"c",
					"h",
					"hpp",
					"cpp",
					"objc",
					"objcpp",
					"cuda",
				},
				init_options = {
					usePlaceholders = true,
					clangdFileStatus = true,
					completeUnimported = true,
					-- fallbackFlags = {
					-- 	"-Wall",
					-- 	"-Wextra",
					-- 	"-Werror",
					-- 	"-I/usr/include",
					-- 	"-I/usr/include/x86_64-linux-gnu",
					-- 	"-D_GNU_SOURCE",
					-- },
				},
			},

			lua_ls = {
				settings = {
					Lua = {
						format = { enable = true },
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
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

		vim.lsp.set_log_level("warn")
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

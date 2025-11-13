return {

	{ "williamboman/mason.nvim", lazy = false, config = function()
			require("mason").setup()
		end }, 

	{ "williamboman/mason-lspconfig.nvim", lazy = false,
		opts = { auto_install = true, }, },

	{ "neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = 'Definition' })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = 'References' })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = 'Code Actions' })
			vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, { desc = 'Rename' })

			vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.jump({count = 1})<CR>', { desc = 'Previous diagnostic' })
			vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.jump({count = -1})<CR>', { desc = 'Next diagnostic' })
			vim.keymap.set('n', '<leader>gq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

			vim.lsp.config("clangd", {
				capabilities = (function()
					capabilities.textDocument.completion.completionItem.snippetSupport = true
					return capabilities
				end)(),
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=bundled",
					"--header-insertion=iwyu",
					"--suggest-missing-includes",
					"--query-driver=/usr/bin/cc*",
					-- "--compile-commands-dir=" .. vim.fn.expand("~/clangd"),
				},
				filetypes = { "c", "cpp", "h" },
				init_options = {
					clangdFileStatus = true,
					usePlaceholders = true, -- enables snippet-like placeholders
					completeUnimported = true,
					fallbackFlags = { "-Wall", "-Wextra", "-Werror" },
				},
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
							checkThirdParty = false
						},
						telemetry = { enable = false }
					}
				}
			})

			vim.diagnostic.config({
				virtual_text  = true,
				severity_sort = true,
				float         = {
					style  = 'minimal',
					border = 'rounded',
					source = 'if_many',
					header = '',
					prefix = '',
				},
				signs         = {
					text = {
						[vim.diagnostic.severity.ERROR] = '✘',
						[vim.diagnostic.severity.WARN]  = '▲',
						[vim.diagnostic.severity.HINT]  = '⚑',
						[vim.diagnostic.severity.INFO]  = '»',
					},
				},
			})
		end,
	},

}

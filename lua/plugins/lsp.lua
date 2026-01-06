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
				"lua_ls",
				-- "bashls",
				"gopls",
			},
			automatic_installation = false,
		})

		local allcapabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(allcapabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.documentHighlight.dynamicRegistration = true

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
		vim.lsp.set_log_level("debug")

		local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local bufnr = args.buf

				---@diagnostic disable-next-line: missing-parameter
				if client and client.supports_method('textDocument/documentHighlight') then
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})


		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
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
					[vim.diagnostic.severity.ERROR] = "X",
					[vim.diagnostic.severity.WARN] = "!",
					[vim.diagnostic.severity.HINT] = "?",
					[vim.diagnostic.severity.INFO] = ">",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.WARN] = "WarningMsg",
				},
			},
		})
	end,
}

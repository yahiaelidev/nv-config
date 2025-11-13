return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local ls = require("luasnip")

			-- Override vim.snippet functions
			vim.snippet.expand = ls.lsp_expand

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.active = function(filter)
				filter = filter or {}
				filter.direction = filter.direction or 1
				if filter.direction == 1 then
					return ls.expand_or_jumpable()
				else
					return ls.jumpable(filter.direction)
				end
			end

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.jump = function(direction)
				if direction == 1 then
					if ls.expandable() then
						return ls.expand_or_jump()
					else
						return ls.jumpable(1) and ls.jump(1)
					end
				else
					return ls.jumpable(-1) and ls.jump(-1)
				end
			end

			vim.snippet.stop = ls.unlink_current

			-- LuaSnip configuration
			ls.config.set_config {
				history = true,
				updateevents = "TextChanged,TextChangedI",
				override_builtin = true,
			}

			-- Load custom snippets
			for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
				loadfile(ft_path)()
			end

			-- Key mappings
			vim.keymap.set({ "i", "s" }, "<c-k>", function()
				return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
			end, { silent = true })

			vim.keymap.del({ "i", "s" }, "<Tab>")
			vim.keymap.del({ "i", "s" }, "<S-Tab>")

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline"
		},

		config = function()
			local cmp = require("cmp")

			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' } }, {
					{ name = 'cmdline' } }),
				matching = { disallow_symbol_nonprefix_matching = false }
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					keyword_length = 0,
				},
				window = {
					completion = cmp.config.window.bordered( {
							border = "none"
						}),
					documentation = cmp.config.window.bordered( {
							border = "none"
						}),
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
					["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						},
						{ "i", "c" }
					),
				},
				sources = cmp.config.sources({
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
			-- in cmp.lua
		end,
	},
}

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		local set = vim.keymap.set

		-- TODO : make things faster
		-- [[
		--exclude .git \
		--exclude node_modules \
		--exclude __pycache__ \
		--exclude .cache \
		--exclude target \
		--exclude dist \
		--exclude build \
		--exclude vendor \
		--exclude .npm \
		--exclude .venv \
		--exclude .cargo \
		--exclude .fzf \
		--exclude .bun \
		--exclude .yarn'
		-- ]]
		fzf.setup({})

		vim.cmd("FzfLua register_ui_select")

		-- stylua: ignore start
		local mappings = {
			["<leader>sb"] = function() fzf.buffers() end,
			["<leader>fg"] = function() fzf.git_files() end,
			["<leader>sf"] = function() fzf.files() end,
			["<leader>sn"] = function() fzf.files({ cwd = "~/.config/nvim/" }) end,

			["<leader>ch"] = function() fzf.command_history() end,
			["<leader>sh"] = function() fzf.helptags() end,
			["<leader>sm"] = function() fzf.manpages() end,

			["<leader>sg"] = function() fzf.grep_cword() end,
			["<leader>gb"] = function() fzf.grep_curbuf() end,

			["grr"] = function() return fzf.lsp_references() end,
			["gri"] = function() fzf.lsp_implementations() end,

			["grd"] = function()
				if vim.bo.filetype == "go" then
					fzf.lsp_definitions()
				else
					fzf.lsp_declarations()
				end
			end,
		}
		-- stylua: ignore end

		for key, fn in pairs(mappings) do
			set("n", key, fn)
		end
	end,
}

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		---@class HarpoonUI
		local harpoon_ui = require("harpoon.ui")
		local orig_render = harpoon_ui._render
		local harpoon = require("harpoon")

		harpoon:setup({})

		vim.keymap.set("n", "<A-a>", function() harpoon:list():add() end)
		vim.keymap.set("n", "<A-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		-- TODO : Think about a better way
		vim.keymap.set("n", "<leader>k", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<leader>h", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end)

		harpoon_ui._render = function(self, state)
			for _, item in ipairs(state.list) do
				item[1] = vim.fn.fnamemodify(item[1], ":~:.")
			end
			return orig_render(self, state)
		end

		local function quickfix_exists()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buftype == "quickfix" then
					return true
				end
			end
			return false
		end

		vim.keymap.set("n", "<A-j>", function()
			if quickfix_exists() then
				vim.cmd("cnext")
				vim.cmd("normal! zz")
			else
				local list = harpoon:list():prev()
				if list and #list.items > 0 then
					list:prev()
				else
					return
				end
			end
		end, { desc = "Quickfix next / Harpoon next" })
		vim.keymap.set("n", "<A-k>", function()
			if quickfix_exists() then
				vim.cmd("cprev")
				vim.cmd("normal! zz")
			else
				local list = harpoon:list():next()
				if list and #list.items > 0 then
					list:next()
				else
					return
				end
			end
		end, { desc = "Quickfix prev / Harpoon prev" })
	end
}

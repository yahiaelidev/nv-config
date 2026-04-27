return {
	---@diagnostic disable: param-type-mismatch
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		---@class HarpoonUI
		local harpoon_ui = require("harpoon.ui")
		local orig_render = harpoon_ui._render
		local harpoon = require("harpoon")

		harpoon:setup({})

		harpoon_ui._render = function(self, state)
			for _, item in ipairs(state.list) do
				item[1] = vim.fn.fnamemodify(item[1], ":~:.")
			end
			return orig_render(self, state)
		end

		local check_quickfix = function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "quickfix" then
					return win
				end
			end
			return nil
		end

		local function move_to(cmd)
			if "harpoon" == vim.bo[0].ft then
				return
			end

			if check_quickfix() then
				if not pcall(vim.cmd, cmd == "next" and "cnext" or "cprev") then
					pcall(vim.cmd, cmd == "next" and "cfirst" or "clast")
				end
				vim.cmd("normal! zz")
				return
			end

			local list = harpoon:list()
			if list and #list.items > 0 then
				if cmd == "next" then
					list:next()
				else
					list:prev()
				end
			end
		end

		vim.keymap.set("n", "<A-j>", function() move_to("next") end, { desc = "Quickfix next / Harpoon next" })
		vim.keymap.set("n", "<A-k>", function() move_to("prev") end, { desc = "Quickfix prev / Harpoon prev" })

		vim.keymap.set("n", "<A-a>", function() harpoon:list():add() end)
		vim.keymap.set("n", "<A-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set("n", "<leader>k", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<leader>h", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end)
	end
}

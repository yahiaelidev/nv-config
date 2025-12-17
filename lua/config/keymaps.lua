local map = vim.keymap.set

---@diagnostic disable-next-line: undefined-global
map("n", "x", '"_x', opts)
map("n", "<leader>m", "'")
map("n", "=ap", "ma=ap'a")
map({ "n", "v" }, "<leader>c", '"_c', { desc = "Delete & Insert + No save to register" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete + No save to register" })

-- happy dev, happy wife
map("i", "bb", "[]<ESC>i")
map("i", "BB", "{}<ESC>i")
map("i", "jj", '""<ESC>i', { noremap = true })
map("i", "kk", "''<ESC>i", { noremap = true })
map("i", "jf", "<ESC>", { noremap = false })

map("n", "<A-j>", "<cmd>cnext<CR>zz", { desc = "<Down> QuickFix" })
map("n", "<A-k>", "<cmd>cprev<CR>zz", { desc = "<Up> Quickfix" })

map("v", "J", ":m '>+1<CR>gv")
map("v", "K", ":m '<-2<CR>gv")

map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")

map("n", "<CS-l>", "<C-w>6<", { desc = "Shorten window" })
map("n", "<CS-h>", "<C-w>6>", { desc = "Lengthen window" })

map("n", "gl", "$")
map("n", "<leader>e", "%")
map("n", "<leader>ye", "y$")
map("x", "<leader>p", [["_dP]])
map("n", "<leader>o", "2o<ESC>O")
map("n", "<leader>O", "2O<ESC>O")
map("n", "<leader><leader>y", "Vy^p")
map("n", "<leader><leader>Y", "Vy^P")
map("n", "<leader><leader>f", "^Vj%o")
map("n", "<leader><leader>a", "A;<ESC>")
map("n", "<leader><leader>i", "i<C-CR><ESC>O")

map("n", "<leader>iq", "ci'") -- i inside
map("n", "<leader>id", 'ci"')
map("n", "<leader>ib", "ci[")
map("n", "<leader>ic", "ci{")
-- map("n", "<leader>aq", "ca'") -- c around
-- map("n", "<leader>ad", 'ca"')
-- map("n", "<leader>ab", "ca[")
-- map("n", "<leader>ac", "ca{")
map("n", "<leader>yq", "yi'") -- yank inside
map("n", "<leader>yd", 'yi"')
map("n", "<leader>yb", "yi[")
map("n", "<leader>yc", "yi{")

map("n", "<leader>q", function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.cmd("quit")
	pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
end, { desc = "Quit & delete the buffer" })

map("n", "<leader>w", function()
	vim.cmd.write()
end, { desc = ":w command" })

map("n", "<leader>td", function()
	vim.cmd("colo catppuccin-mocha")
end, { desc = "Dark Mode catppuccin-mocha" })

map("n", "<leader>tl", function()
	vim.cmd(":colo catppuccin-latte")
end, { desc = "Light Mode catppuccin-mocha" })

local function insert_blank_line(above)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local setLine = vim.api.nvim_buf_set_lines
	local setCursor = vim.api.nvim_win_set_cursor

	if above then
		setLine(0, row - 1, row - 1, false, { "" })
		setCursor(0, { row + 1, col })
	else
		setLine(0, row, row, false, { "" })
		setCursor(0, { row, col })
	end
end

vim.keymap.set("n", "<leader>9", function()
	insert_blank_line(true)
end, { desc = "Add empty line above" })
vim.keymap.set("n", "<leader>0", function()
	insert_blank_line(false)
end, { desc = "Add empty line below" })

map("n", "<up>", '<cmd>echo "in your dreams"<CR>')
map("n", "<left>", '<cmd>echo "in your dreams"<CR>')
map("n", "<down>", '<cmd>echo "in your dreams"<CR>')
map("n", "<right>", '<cmd>echo "in your dreams"<CR>')
map("n", "<ESC>", "<cmd>nohlsearch<CR>", { silent = true })

map("n", "<leader><leader>x", "<cmd>source %<CR>", {
	desc = "Execute the current file",
})

local map = vim.keymap.set

---@diagnostic disable-next-line: undefined-global
map("n", "x", '"_x', opts)
map("n", "<leader>m", "'")
map("n", "=ap", "ma=ap'a")
map({ "n", "v" }, "<leader>c", '"_c')
map({ "n", "v" }, "<leader>d", '"_d')

-- happy dev, happy wife
map("i", "bb", "[]<ESC>i")
map("i", "BB", "{}<ESC>i")
map("i", "jj", '""<ESC>i', { noremap = true })
map("i", "kk", "''<ESC>i", { noremap = true })
map("i", "jf", "<ESC>", { noremap = false })

map("v", "J", ":m '>+1<CR>gv")
map("v", "K", ":m '<-2<CR>gv")

map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")

map("n", "<CS-l>", "<C-w>6<")
map("n", "<CS-h>", "<C-w>6>")

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
map("n", "<leader>aq", "ca'") -- c around
map("n", "<leader>ad", 'ca"')
map("n", "<leader>ab", "ca[")
map("n", "<leader>ac", "ca{")
map("n", "<leader>yq", "yi'") -- yank inside
map("n", "<leader>yd", 'yi"')
map("n", "<leader>yb", "yi[")
map("n", "<leader>yc", "yi{")

map("n", "<leader>q", ":quit <CR>")
map("n", "<leader>w", function()
	vim.cmd.write()
end)

map("n", "<leader>tf", ":FzfLua colorschemes<CR>")
map("n", "<leader>td", function()
	vim.cmd("colo catppuccin-mocha")
end)
map("n", "<leader>tl", function()
	vim.cmd(":colo catppuccin-latte")
end)

map("n", "<up>", '<cmd>echo "in your dreams"<CR>')
map("n", "<left>", '<cmd>echo "in your dreams"<CR>')
map("n", "<down>", '<cmd>echo "in your dreams"<CR>')
map("n", "<right>", '<cmd>echo "in your dreams"<CR>')
map("n", "<ESC>", "<cmd>nohlsearch<CR>", { silent = true })

map("n", "<leader><leader>x", "<cmd>source %<CR>", {
	desc = "Execute the current file",
})

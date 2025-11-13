local map = vim.keymap.set

map('n', 'x', '"_x', opts)
map("n", "<leader>m", "'")
map("n", "=ap", "ma=ap'a")

map("n", "<leader>iq", "ci'")
map("n", "<leader>id", 'ci"')
map("n", "<leader>ib", "ci[")
map("n", "<leader>ic", "ci{")

map("n", "<leader>aq", "ca'")
map("n", "<leader>ad", 'ca"')
map("n", "<leader>ab", "ca[")
map("n", "<leader>ac", "ca{")

map("n", "<leader>yq", "yi'")
map("n", "<leader>yd", 'yi"')
map("n", "<leader>yb", "yi[")
map("n", "<leader>yc", "yi{")

map("v", "J", ":m '>+1<CR>gv")
map("v", "K", ":m '<-2<CR>gv")

map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-j>', '<C-w><C-j>')

map('n', '<CS-l>', '<C-w>6<')
map('n', '<CS-h>', '<C-w>6>')

map("x", "<leader>p", [["_dP]])
map("n", "<leader>o", "2o<ESC>O")
map("n", "<leader>O", "2O<ESC>O")
map("n", "<leader><leader>a", "A;<ESC>")

map("n", "gl", "$")
map("n", "<leader>ye", "y$")
map('n', '<leader><leader>y', 'Vy^p')
map('n', '<leader><leader>Y', 'Vy^P')
map('n', '<leader><leader>f', '^Vj%o')
map('n', '<leader><leader>i', 'i<C-CR><ESC>O')

map("n", "<leader>q", ':quit <CR>')
map("n", "<leader>w", function()
	-- local ft = vim.bo.filetype
    -- if ft == "c" or ft == "h" then
    --     vim.cmd(":CFormatter42")
    -- end
    vim.cmd.write()
end)

map("n", "<leader>tf", ":FzfLua colorschemes<CR>")
map("n", "<leader>tl", function()
	vim.cmd(":colo tairiki-light")
	vim.cmd(":hi indentline guifg=#ededed")
	vim.cmd(":hi indentlinecurrent guifg=#466969")
end)

map("n", "<leader>td", function()
	vim.cmd('colo everblush')
	vim.cmd(":hi statusline guibg=NONE")
	vim.cmd(":hi LineNR guifg=#808080")
	vim.cmd(":hi StatuslineNC guifg=#808080")
	vim.cmd(":hi indentline guifg=#1d2b2b")
	vim.cmd(":hi indentlinecurrent guifg=#466969")
end)

map({ "n", "v" }, "<leader>d", "\"_d")
map("i", "jf", "<ESC>", { noremap = false })

map('n', '<A-BS>', '<cmd>nohlsearch<CR>', { silent = true })
map('n', '<up>', '<cmd>echo "Don\'t you ever try that again"<CR>')
map('n', '<left>', '<cmd>echo "Don\'t you ever try that again"<CR>')
map('n', '<down>', '<cmd>echo "Don\'t you ever try that again"<CR>')
map('n', '<right>', '<cmd>echo "Don\'t you ever try that again"<CR>')

map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.keymap.set("i", "ii", ":= ")
vim.keymap.set("i", "nah", ", _ := ")
vim.keymap.set("n", "<leader>run", function()
	vim.cmd("!go run .")
end)

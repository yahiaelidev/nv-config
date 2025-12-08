vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.keymap.set("i", "ii", ":= ", { buffer = 0 })
vim.keymap.set("i", "nah", ", _ := ", { buffer = 0 })
vim.keymap.set("n", "<leader>run", function()
	vim.cmd("!go run .")
end, { buffer = 0 })

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.keymap.set("n", "<leader>run", ":w<CR>:!bun %<CR>")
vim.keymap.set("i", "__", "=>", { buffer = 0 })
vim.keymap.set("i", "ii", "= ;<ESC>i", { buffer = 0 })

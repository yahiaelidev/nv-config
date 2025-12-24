vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt_local.cindent = true
vim.opt_local.smartindent = true

vim.keymap.set("i", "__", "->", { buffer = 0 })

-- TODO: Coloring the output with nvim API
local cmaps = {
	gc = "fclean",
	gv = "v",
	gr = "run",
}

for k, v in pairs(cmaps) do
	vim.keymap.set("n", "<leader>" .. k, "<cmd>belowright split | resize 10 | terminal make " .. v .. "<CR>", {
		desc = "Make " .. v,
		buffer = 0,
	})
end

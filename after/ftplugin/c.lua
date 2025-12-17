vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = false
vim.opt_local.cindent = true
vim.opt_local.smartindent = true

vim.keymap.set("i", "__", "->", { buffer = 0 })

-- TODO: Coloring the output with nvim API
local cmaps = {
	gc = "run",
	gv = "v",
}

for k, v in pairs(cmaps) do
	vim.keymap.set("n", "<leader>" .. k, "<cmd>belowright split | resize 15 | terminal make " .. v .. "<CR>", {
		desc = "Make " .. v,
		buffer = 0,
	})
end

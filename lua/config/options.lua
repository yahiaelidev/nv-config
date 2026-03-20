vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.env.TERM = "xterm-256color"
vim.opt.termguicolors = true
vim.o.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.winborder = "none"
vim.opt.breakindent = true
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.viewoptions = "folds,cursor,slash,unix" -- for fold only
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.confirm = true
vim.opt.numberwidth = 3
vim.opt.swapfile = false
vim.opt.showtabline = 1

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.splitright = true
vim.opt.splitbelow = true

--disable tildes
vim.opt.fillchars = { eob = " " }

-- vim.g.c_indent_off = true
vim.opt.cindent = true
vim.opt.smarttab = false
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.o.signcolumn = "yes"

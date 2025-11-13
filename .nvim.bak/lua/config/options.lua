vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.o.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.winborder = 'none'
vim.opt.termguicolors = true
vim.opt.breakindent = true
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = false

vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.confirm = true
vim.opt.numberwidth = 4
vim.opt.swapfile = false
vim.opt.showtabline = 1

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

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
vim.opt.autoindent = true -- Keep identation from previous line
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.expandtab = false -- tabs to spaces 
vim.opt.tabstop = 4 -- How many spaces are shown per Tab
vim.o.signcolumn = "yes"

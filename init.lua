vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.c-term")
require("config.lazy")

vim.g.astro_typescript = 'enable'
vim.g.astro_stylus = 'enable'

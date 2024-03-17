local o = vim.o
local cmd = vim.cmd

o.termguicolors = true
o.swapfile = false
cmd.colorscheme("industry")

-- install required plugins
vim.opt.runtimepath:prepend(vim.fn.getcwd())

-- remap leader
vim.g.mapleader = " "

-- set up kitty-runner
require("kitty-runner").setup()

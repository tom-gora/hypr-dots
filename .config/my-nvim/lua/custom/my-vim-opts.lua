-- map the leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.editorconfig = true

-- declare encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- set my line numbers to rel
vim.opt.number = true
vim.opt.relativenumber = true

-- all the indentation stuff
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- pretty colors
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = "~" }

-- splits stuff
vim.opt.inccommand = "split"
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current

-- cmdline tweaks
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.cmdheight = 0

-- text editor tweaks
vim.opt.wrap = false
vim.opt.virtualedit = "block"
vim.opt.scrolloff = 999
vim.opt.cursorline = true

-- ui tweaks
vim.opt.showtabline = 0

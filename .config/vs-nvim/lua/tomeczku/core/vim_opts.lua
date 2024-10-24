local opt = vim.opt
-- map the leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.editorconfig = true

opt.cursorline = true
-- declare encoding
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- netrw tree
vim.cmd("let g:netrw_liststyle = 3")

-- set my line numbers to rel
opt.number = true
opt.relativenumber = true
opt.numberwidth = 1

-- sync + reg to system clipboard
opt.clipboard:prepend("unnamedplus")

-- all the indentation and lines stuff
opt.wrap = false
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- pretty colors
opt.termguicolors = true
opt.background = "dark"
opt.hlsearch = true

-- splits stuff
opt.inccommand = "split"
opt.splitbelow = true
opt.splitright = true

-- cmdline tweaks
opt.ignorecase = true
opt.smartcase = true
opt.cmdheight = 0

-- text editor tweaks
opt.wrap = true
opt.virtualedit = "block"
opt.scrolloff = 999
opt.cursorline = true
opt.signcolumn = "yes"

-- ui tweaks
opt.showtabline = 0
opt.fillchars = {
	eob = "◦",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
opt.listchars = { eol = "↲" }
opt.list = true

-- enable undofile
opt.undofile = true

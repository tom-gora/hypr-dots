vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local opts = { dir = vim.fn.stdpath("data") .. "/plugins./" }

-- import plugins intended for in-vscode neovim instance
require("lazy").setup({
	{
		{ import = "plugins" },
	}
})
-- import mappings file
require("mappings")
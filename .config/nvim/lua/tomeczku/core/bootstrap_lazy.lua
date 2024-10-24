local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.lazy_conf")
end

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

-- for nvim load regular setup
if not vim.g.vscode then
	require("lazy").setup(conf)
-- otherwise a minimal table where plugins that work and are useful inside
-- vscode embedded instance can be transfered
else
	local vs_plugins = require("tomeczku.vs_code").vscode_plugins
	require("lazy").setup(vs_plugins)
end

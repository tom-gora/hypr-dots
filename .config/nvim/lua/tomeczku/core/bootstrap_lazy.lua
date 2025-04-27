if vim.g.vscode then
	return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local conf = {
	spec = {
		import = "tomeczku.plugins",
	},
	ui = {
		title = " 󰒲 Lazy ",
		border = "rounded",
		title_pos = "left",
		size = { width = 0.7, height = 0.8 },
	},
	--
	-- NOTE: OPTIMIZE FOR DEBUGGING CONFIG IF DEBUG BOOL IS SET
	--
	install = {
		-- When in debug mode, install missing plugins right away
		missing = init_debug,
	},
	-- If debugging, reduce Lazy's own startup optimizations
	performance = {
		-- Set to false when debugging to avoid various optimizations
		cache = not init_debug,
		reset_packpath = not init_debug,
	},
	-- Consider adding a custom handler for events
	hooks = {
		-- This runs before any plugins load
		pre_load = function()
			if init_debug then
				vim.notify("Lazy pre-load hook: Preparing for debug session", vim.log.levels.INFO)
			end
		end,
	},
}

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

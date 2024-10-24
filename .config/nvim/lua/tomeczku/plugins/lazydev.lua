local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.lazydev_conf")
end

M = {
	{
		"folke/lazydev.nvim",
		cond = vim.g.vscode == nil,
		ft = "lua", -- only load on lua files
		dependencies = conf.dependencies,
		opts = conf.opts,
	},
}

return M

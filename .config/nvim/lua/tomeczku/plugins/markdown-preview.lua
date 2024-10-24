local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.markdown_preview_conf")
end

M = {
	{
		"iamcco/markdown-preview.nvim",
		cond = vim.g.vscode == nil,
		lazy = true,
		cmd = conf.cmd,
		build = conf.build_cmd,
		config = conf.config,
		ft = { "markdown" },
	},
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown" },
	},
}

return M

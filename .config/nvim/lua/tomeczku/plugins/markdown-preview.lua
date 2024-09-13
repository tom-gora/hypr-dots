local M = {}
local conf = require("tomeczku.configs.markdown_preview_conf")
M = {
	{
		"iamcco/markdown-preview.nvim",
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

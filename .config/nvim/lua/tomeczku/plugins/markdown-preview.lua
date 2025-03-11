local M
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.markdown_preview_conf")
end

M = {
	{
		-- clone from my backup fork of fixed package that wasn't merged
		-- attribution for fix: Knyffen/markdown-preview.nvim
		-- "Knyffen/markdown-preview.nvim",
		"tom-gora/markdown-preview.nvim",
		cond = vim.g.vscode == nil,
		lazy = false,
		cmd = conf.cmd,
		build = conf.build_cmd,
		config = conf.config,
		ft = { "markdown" },
	},
}

return M

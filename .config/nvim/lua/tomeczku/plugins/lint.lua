-- luacheck: globals vim
local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.lint_conf")
end

M = {
	"rshkarin/mason-nvim-lint",
	cond = vim.g.vscode == nil,
	dependencies = {
		{
			"mfussenegger/nvim-lint",
			enabled = false,
			event = conf.event,
			config = conf.config_function,
		},
		{
			"rachartier/tiny-inline-diagnostic.nvim",
			event = "LspAttach", -- Or `LspAttach`
			priority = 1000, -- needs to be loaded in first
			config = function()
				require("tiny-inline-diagnostic").setup()
				vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
			end,
		},
	},
}
return M

local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.lazygit_conf")
end

M = {
	"kdheepak/lazygit.nvim",
	cond = vim.g.vscode == nil,
	cmd = conf.cmd,
	window_chars = conf.chars,
	config = conf.config_function,
}

return M

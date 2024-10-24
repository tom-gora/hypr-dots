-- tailwind configs that work found here:
-- https://github.com/Wansmer/nvim-config/blob/4d7fa6c02474f38755202e679cb7e398b5e96e44/lua/config/plugins/cmp.lua#L121
--
local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.cmp_conf")
end

M = {
	"hrsh7th/nvim-cmp",
	cond = vim.g.vscode == nil,
	lazy = true,
	event = "InsertEnter",
	dependencies = conf.dependencies,
	config = conf.config_function,
}

return M

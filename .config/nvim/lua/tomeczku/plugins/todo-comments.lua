-- src: https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/todo-comments.lua
local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.todo_comments_conf")
end

M = {
	"folke/todo-comments.nvim",
	cond = vim.g.vscode == nil,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = conf.dependencies,
	config = conf.config_function,
}

return M

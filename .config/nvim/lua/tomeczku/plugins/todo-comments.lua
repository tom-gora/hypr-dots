if vim.g.vscode then
	return
end

local M, config_function

config_function = function()
	local todo_comments = require("todo-comments")
	-- set keymaps
	local map = vim.keymap.set -- for conciseness

	map("n", "tl", function()
		todo_comments.jump_next()
	end, { desc = "Next todo comment" })

	map("n", "th", function()
		todo_comments.jump_prev()
	end, { desc = "Previous todo comment" })

	todo_comments.setup()
end

M = {
	"folke/todo-comments.nvim",
	cond = vim.g.vscode == nil,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = config_function,
}

return M

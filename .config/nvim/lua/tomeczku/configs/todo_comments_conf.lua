-- src: https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/todo-comments.lua
local M = {}

M.dependencies = { "nvim-lua/plenary.nvim" }

M.config_function = function()
	local todo_comments = require("todo-comments")
	-- set keymaps
	local keymap = vim.keymap -- for conciseness

	keymap.set("n", "tl", function()
		todo_comments.jump_next()
	end, { desc = "Next todo comment" })

	keymap.set("n", "th", function()
		todo_comments.jump_prev()
	end, { desc = "Previous todo comment" })

	todo_comments.setup()
end

return M

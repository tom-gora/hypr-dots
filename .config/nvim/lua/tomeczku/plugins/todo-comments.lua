if vim.g.vscode then
end

local M, config_function

config_function = function()
	local td, map = require("todo-comments"), vim.keymap.set

	map("n", "tj", function()
		td.jump_next()
	end, { silent = true, noremap = true, desc = "Next TODO comment" })

	map("n", "tk", function()
		td.jump_prev()
	end, { silent = true, noremap = true, desc = "Previous TODO comment" })

	map("n", "<leader>ft", function()
		require("todo-comments.fzf").todo()
	end, { silent = true, noremap = true, desc = "Find TODOs" })

	td.setup()
end

M = {
	"folke/todo-comments.nvim",
	cond = vim.g.vscode == nil,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = config_function,
}

return M

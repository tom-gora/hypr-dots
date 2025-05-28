if vim.g.vscode then
	return
end

local M, opts, init_function

opts = {
	preset = "helix",
	show_help = false,
	icons = { separator = "", group = "", rules = false },
	win = {
		border = "solid",
		row = 1,
		title_pos = "right",
		title = true,
	},
	presets = {
		text_objects = false,
		operators = false,
		motions = false,
	},
	triggers = {
		{ "<auto>", mode = "nixsotc" },
	},
}

init_function = function()
	vim.o.timeout = true
	vim.o.timeoutlen = 250
end

M = {
	"folke/which-key.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	init = init_function,
	opts = opts,
}

return M

if vim.g.vscode then
	return
end

local M, opts, init_function

opts = {
	preset = "modern",
	icons = { separator = "", group = "", rules = false },
	win = {
		border = "rounded",
		title_pos = "left",
		title = true,
		padding = { 1, 4 },
		width = math.max(math.floor(vim.o.columns * 0.55), 50),
	},
	layout = {
		width = { min = 20 },
		spacing = 5,
		align = "right",
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

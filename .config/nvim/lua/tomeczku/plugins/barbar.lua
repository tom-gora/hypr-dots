if vim.g.vscode then
	return
end

local M, opts, dependencies, init_function

opts = {
	animation = true,
	auto_hide = 1,
	tabpages = false,
	clickable = false,
	focus_on_close = "previous",
	icons = {
		buffer_index = true,
		button = false,
		separator = { left = "", right = "" },
		modified = { button = " 󰴓" },
		inactive = {
			separator = { left = " ", right = " " },
			filetype = { enabled = false },
		},
	},
	minimum_padding = 0,
	maximum_padding = 0,
	exclude_ft = { "oil", "qf" },
}

dependencies = {
	"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
	"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
}

init_function = function()
	vim.g.barbar_auto_setup = false
end

M = {
	"romgrk/barbar.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	dependencies = dependencies,
	init = init_function(),
	opts = opts,
}

return M

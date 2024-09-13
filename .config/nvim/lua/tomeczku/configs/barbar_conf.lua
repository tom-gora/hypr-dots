local M = {}

M.opts = {
	animation = false,
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

M.dependencies = {
	"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
	"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
}

M.init_function = function()
	vim.g.barbar_auto_setup = false
end

return M

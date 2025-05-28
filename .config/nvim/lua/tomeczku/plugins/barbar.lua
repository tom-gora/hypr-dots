if vim.g.vscode then
	return
end

-- local M, opts, dependencies, init_function
--
-- opts = {
-- 	animation = true,
-- 	auto_hide = 1,
-- 	tabpages = false,
-- 	clickable = false,
-- 	focus_on_close = "previous",
-- 	icons = {
-- 		buffer_index = true,
-- 		button = false,
-- 		separator = { left = "", right = "" },
-- 		modified = { button = " 󰴓" },
-- 		inactive = {
-- 			separator = { left = " ", right = " " },
-- 			filetype = { enabled = false },
-- 		},
-- 	},
-- 	minimum_padding = 0,
-- 	maximum_padding = 0,
-- 	exclude_ft = { "oil", "qf" },
-- }
--
-- dependencies = {
-- 	"nvim-tree/nvim-web-devicons",
-- }
--
-- init_function = function()
-- 	vim.g.barbar_auto_setup = false
-- end
--
-- M = {
-- 	"romgrk/barbar.nvim",
-- 	cond = vim.g.vscode == nil,
-- 	enabled = false,
-- 	event = "VeryLazy",
-- 	dependencies = dependencies,
-- 	init = init_function(),
-- 	opts = opts,
-- }
local M = {
	"b0o/incline.nvim",
	enabled = false,
	config = function()
		local helpers = require("incline.helpers")
		local devicons = require("nvim-web-devicons")
		require("incline").setup({
			window = {
				padding = 0,
				margin = { horizontal = -1 },
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = ""
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified
				return {
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
					" ",
					{ filename, gui = modified and "bold,italic" or "bold" },
					" ",
					guibg = "#44406e",
				}
			end,
		})
	end,
	-- Optional: Lazy load Incline
	event = "VeryLazy",
}

return M

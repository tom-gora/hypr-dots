local M

M = {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		notify.setup({
			top_down = false,
			render = "minimal",
			stages = "static",
			icons = {
				ERROR = "󰬌",
				WARN = "󰬞",
				INFO = "󰬐",
				DEBUG = "󰬉",
				TRACE = "󰬛",
			},
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { border = "solid" })
			end,
		})

		vim.notify = notify
	end,
	opts = {},
}

return M

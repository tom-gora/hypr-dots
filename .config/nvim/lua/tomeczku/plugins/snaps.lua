local M

M = {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	opts = {
		theme = "rose-pine-moon",
		background = "#ffffff",
		disable_defaults = false,
		to_clipboard = true,
		no_window_controls = false,
		no_line_number = false,
		line_offset = function(args)
			return args.line1
		end,
		tab_width = 2,
		window_title = function()
			return "    Spapshot from: "
				.. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
		end,
		language = function()
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":e")
		end,
		output = function()
			return os.getenv("HOME")
				.. "/Pictures/CodeSnapshots/"
				.. os.date("!%Y-%m-%dT%H-%M-%SZ")
				.. "_code_snapshot.png"
		end,
	},
}

return M

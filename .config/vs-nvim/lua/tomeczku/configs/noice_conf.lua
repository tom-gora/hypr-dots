local M = {}
local override = function(direction)
	local top = 0
	local bottom = vim.opt.lines:get() - (vim.opt.cmdheight:get() + (vim.opt.laststatus:get() > 0 and 1 or 0))
	if vim.wo.winbar then
		bottom = bottom - 1
	end
	local left = 1
	local right = vim.opt.columns:get()
	if direction == "top_down" then
		return top, bottom
	elseif direction == "bottom_up" then
		return bottom, top
	elseif direction == "left_right" then
		return left, right
	elseif direction == "right_left" then
		return right, left
	end
	error(string.format("Invalid direction: %s", direction))
end

M.no_spinner = function()
	local format = require("noice.config.format")
	local lsp_progress_new = {
		{
			"{progress}",
			key = "progress.percentage",
		},
		{ " {spinner}  ", hl_group = "NoiceLspProgressSpinner" },
		{ " {data.progress.percentage}  " },
		{ " {data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
		{ " {data.progress.client} ", hl_group = "NoiceLspProgressClient" },
	}
	format.builtin.lsp_progress = lsp_progress_new
end

M.opts = {
	lsp = {
		progress = {
			view = "notify",
			throttle = 100,
		},
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	cmdline = {
		view = "cmdline",
	},
	views = {
		notify = {
			replace = true,
			merge = true,
		},
	},

	presets = {
		lsp_doc_border = true,
		long_message_to_split = true,
		command_palette = {
			views = {
				cmdline_popupmenu = {
					relative = "win",
					position = {
						row = -2,
						col = 0,
					},
					size = {
						width = 35,
						height = "auto",
						max_height = 6,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "String" },
					},
					scrollbar = false,
				},
			},
		},
	},
}

M.dependencies = {
	"MunifTanjim/nui.nvim",
	{
		"rcarriga/nvim-notify",
		config = vim.schedule(function()
			local util = require("notify.stages.util")
			util.get_slot_range = override
		end),
		opts = {
			background_colour = "NotifyBackground",
			fps = 30,
			icons = {
				DEBUG = " ",
				ERROR = " ",
				INFO = " ",
				TRACE = "✎ ",
				WARN = " ",
			},
			level = 2,
			minimum_width = 40,
			max_width = 50,
			render = "wrapped-compact",
			-- stages = "fade_in_slide_out",
			stages = "static",
			time_formats = {
				notification = "%T",
				notification_history = "%FT%T",
			},
			timeout = 4000,
			top_down = false,
		},
	},
}

return M

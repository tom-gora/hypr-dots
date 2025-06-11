local M
local api = vim.api

local set_split = function(bufnr, name)
	local cols = vim.o.columns
	local lines = vim.o.lines

	if cols <= 110 then
		vim.cmd("belowright split")
		local win_id = vim.api.nvim_get_current_win()
		_G.AIDER_RUNNING = win_id
		api.nvim_set_option_value("winhighlight", "Normal:NormalFloat", { win = focused_win })
		api.nvim_win_set_buf(win_id, bufnr)

		local fractional_height = math.floor(lines * 0.3)
		api.nvim_win_set_height(win_id, math.max(fractional_height, 10))
		return
	end
	vim.cmd("vsplit")
	local win_id = vim.api.nvim_get_current_win()
	_G.AIDER_RUNNING = win_id
	api.nvim_win_set_option(win_id, "winhighlight", "Normal:NormalFloat")
	api.nvim_win_set_buf(win_id, bufnr)

	local fractional_width = math.floor(cols * 0.4)
	api.nvim_win_set_width(win_id, math.max(fractional_width, 35))
end

local repl_args = {
	aider = {
		"--no-auto-commits --stream",
		"--fancy-input",
		--"--subtree-only",
		"--config",
		"$HOME/.config/aider/aider-default.conf.yml",
	},
}

local arg_string_builder = function(args)
	local args_str = ""
	for _, arg in ipairs(args) do
		args_str = args_str .. " " .. arg
	end
	return args_str
end

local set_extra_keymaps = function()
	local map = vim.keymap.set
	local h = require("tomeczku.core.keymaps.helpers")

	map({ "n", "x" }, "<leader>ta", function()
		local focused_win = api.nvim_get_current_win()
		if not _G.AIDER_RUNNING or _G.AIDER_RUNNING == nil then
			vim.cmd("REPLStart aider")
			return
		elseif _G.AIDER_RUNNING and _G.AIDER_RUNNING ~= nil and focused_win ~= _G.AIDER_RUNNING then
			vim.cmd("REPLFocus aider")
			return
		end
		vim.cmd("REPLHide aider")
	end, h.setOpts({ desc = "Toggle Aider Terminal" }))
end

local yarepl_opts = {
	buflisted = true,
	scratch = true,
	ft = "REPL",
	wincmd = set_split,
	-- The available REPL palattes that `yarepl` can create REPL based on.
	-- To disable a built-in meta, set its key to `false`, e.g., `metas = { R = false }`
	metas = {
		aider = {
			cmd = "TERM=xterm-256color RUNNING_IN_REPL_BUFFER=1 aider " .. arg_string_builder(repl_args.aider),
			formatter = "bracketed_pasting",
			source_syntax = "aichat",
		},
		bash = {
			cmd = "bash",
			formatter = vim.fn.has("linux") == 1 and "bracketed_pasting" or "trim_empty_lines",
			source_syntax = "bash",
		},
		zsh = { cmd = "zsh", formatter = "bracketed_pasting", source_syntax = "bash" },
	},
	-- when a REPL process exits, should the window associated with those REPLs closed?
	close_on_exit = true,
	-- whether automatically scroll to the bottom of the REPL window after sending
	-- text? This feature would be helpful if you want to ensure that your view
	-- stays updated with the latest REPL output.
	scroll_to_bottom_after_sending = true,
	-- Format REPL buffer names as #repl_name#n (e.g., #ipython#1) instead of using terminal defaults
	format_repl_buffers_names = true,
	-- Display the first line as virtual text to indicate the actual
	-- command sent to the REPL.
	source_command_hint = {
		enabled = true,
		hl_group = "Comment",
	},
}
M = {
	"milanglacier/yarepl.nvim",
	config = function()
		require("yarepl").setup(yarepl_opts)

		set_extra_keymaps()

		local aider_helpers = api.nvim_create_augroup("AiderHelpers", { clear = true })
		api.nvim_create_autocmd("TermClose", {
			group = aider_helpers,
			callback = function(e)
				local term_file = e.file or e.match
				if
					not term_file
					or not string.find(string.lower(term_file), "aider")
					or not _G.AIDER_RUNNING
					or _G.AIDER_RUNNING == nil
				then
					return
				end
				_G.AIDER_RUNNING = nil
			end,
		})
	end,
}

return M

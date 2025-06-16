local M, api = {}, vim.api
local utils = require("tomeczku.plugins.yarepl.__utils")
local aider = require("tomeczku.plugins.yarepl.__config_aider")
local goose = require("tomeczku.plugins.yarepl.__config_goose")
local lua_repl = require("tomeczku.plugins.yarepl.__config_lua_repl")
local todos = require("tomeczku.plugins.yarepl.__config_todo")

local plugin_opts = {
	buflisted = true,
	scratch = true,
	ft = "REPL",
	wincmd = utils.set_split,
	metas = {
		-- DISABLED:
		aichat = false,
		radian = false,
		ipython = false,
		python = false,
		R = false,
		-- bash = {
		--   cmd = "bash",
		--   formatter = vim.fn.has("linux") == 1 and "bracketed_pasting" or "trim_empty_lines",
		--   source_syntax = "bash",
		-- },
		bash = false,
		-- ENABLED:
		aider = {
			cmd = "TERM=xterm-256color RUNNING_IN_REPL_BUFFER=1 aider " .. utils.concat_args(aider.args),
			formatter = "bracketed_pasting",
			source_syntax = "aichat",
		},
		goose = { cmd = "goose", formatter = "bracketed_pasting", source_syntax = "bash" },
		lua = { cmd = "croissant", formatter = "bracketed_pasting", source_syntax = "lua" },
		zsh = { cmd = "zsh", formatter = "bracketed_pasting", source_syntax = "bash" },
		todo = {
			cmd = vim.env.shell .. " -c todo; exec " .. vim.env.shell .. " -i",
			formatter = "bracketed_pasting",
			source_syntax = "bash",
		},
	},
	close_on_exit = true,
	scroll_to_bottom_after_sending = true,
	format_repl_buffers_names = true,
	source_command_hint = {
		enabled = false,
	},
}

M = {
	"milanglacier/yarepl.nvim",
	config = function()
		-- set global state to manage opened repls, prevent opening multiple etc.
		_G.ACTIVE_REPLS = {}
		require("yarepl").setup(plugin_opts)

		local ok, wk = pcall(require, "which-key")
		if ok then
			wk.add({
				mode = { "n", "x" },
				{ "<leader>t", group = " REPL Terminals" },
			})
		end

		utils.set_autocmds()
		todos.setup()
		aider.setup()
		lua_repl.setup()
		goose.setup()
	end,
}

return M

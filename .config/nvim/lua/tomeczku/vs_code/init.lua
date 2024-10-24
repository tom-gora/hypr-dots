local M = {}

M.vscode_plugins = {
	{
		"nat-418/boole.nvim",
		-- cond = vim.g.vscode == nil,
		opts = {
			mappings = {
				increment = "<C-a>",
				decrement = "<C-x>",
			},
			allow_caps_additions = {
				{ "enable", "disable" },
				{ "off", "on" },
			},
		},
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			highlight_duration = 1000,
		},
		config = true,
	},
	{
		"echasnovski/mini.move",
		version = "*",
		opts = {
			reindent_linewise = true,
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<a-h>",
				right = "<a-l>",
				down = "<a-j>",
				up = "<a-k>",

				-- Move current line in Normal mode
				line_left = "<a-h>",
				line_right = "<a-l>",
				line_down = "<a-j>",
				line_up = "<a-k>",
			},
		},
		lazy = false,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		event = "VeryLazy",
		config = true,
	},
}
M.vscode_other = {
	autocommands = function()
		vim.api.nvim_create_autocmd("TextYankPost", {
			group = vim.api.nvim_create_augroup("TextYankPost", { clear = true }),
			callback = function()
				vim.highlight.on_yank({
					timeout = 200,
					higroup = "MatchWord",
				})
			end,
			pattern = "*",
		})
	end,
	focus_file_explorer = "<cmd>lua require('vscode').call('workbench.files.action.focusFilesExplorer')<cr>",
	open = {
		last_closed = "<cmd>lua require('vscode').call('workbench.action.reopenClosedEditor')<cr>",
		open_recent = "<cmd>lua require('vscode').call('workbench.action.openRecent')<cr>",
		new_untitled_file = "<cmd>lua require('vscode').call('openEditors.newUntitledFile')<cr>",
		quick_open = "<cmd>lua require('vscode').call('workbench.action.quickOpen')<cr>",
		open_folder = "<cmd>lua require('vscode').call('workbench.action.files.openFolder')<cr>",
		close_active_editor = "<cmd>lua require('vscode').call('workbench.action.closeActiveEditor')<cr>",
		quit = "<cmd>lua require('vscode').call('workbench.action.quit')<cr>",
		close_all_editors = "<cmd>lua require('vscode').call('workbench.action.closeAllEditors')<cr>",
		close_other_editors = "<cmd>lua require('vscode').call('workbench.action.closeOtherEditors')<cr>",
		close_unmodified_editors = "<cmd>lua require('vscode').call('workbench.action.closeUnmodifiedEditors')<cr>",
		extensions = "<cmd>lua require('vscode').call('workbench.view.extensions')<cr>",
	},
}

return M

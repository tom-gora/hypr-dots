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
	vim_opts_and_other_basics = function()
		-- SILENCE, BUFFER!
		vim.opt.cmdheight = 1
		vim.opt.shortmess:append({
			a = true,
			S = true,
			s = true,
			c = true,
			W = true,
			F = true,
			A = true,
			o = true,
		})
		-- fix notifications
		vim.notify = require("vscode").notify
	end,
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
}

M.vscode_register_keymaps = function()
	local vscode = require("vscode")
	local map = vim.keymap.set
	local opts = { silent = true, noremap = true }

	--fixes to mappings
	map("x", "p", "P", opts)
	map("n", "ciw", '"_ciw', opts)
	map("n", "caw", '"_caw', opts)
	map("n", "<leader>a", "ggVG", opts)
	map("n", "p", "gp", opts)
	map({ "n", "x" }, "c", '"_c', opts)
	map({ "n", "x" }, "x", '"_x', opts)
	map({ "n", "x" }, "d", '"_d', opts)
	-- hi reset
	map("n", "<Esc>", "<cmd>noh<cr>", opts)
	-- linewise selection
	map({ "n", "x" }, "<leader><leader>", "V", opts)
	-- my custom shite
	map("n", "gz", "<cmd>MultiplyLineWithIndexing<cr>", opts)
	map("x", "gz", ":<c-u>ApplyIndexingOverSelection<cr>", opts)
	-- call opening file tree from editor
	map("n", "<leader>e", function()
		vscode.call("workbench.files.action.focusFilesExplorer")
	end, opts)
	-- call opening commands
	map({ "n", "x" }, "<leader>oc", function()
		vscode.call("workbench.action.reopenClosedEditor")
	end, opts)
	map({ "n", "x" }, "<leader>or", function()
		vscode.call("workbench.action.openRecent")
	end, opts)
	map({ "n", "x" }, "<leader>on", function()
		vscode.call("openEditors.newUntitledFile")
	end, opts)
	map({ "n", "x" }, "<leader>oo", function()
		vscode.call("workbench.action.quickOpen")
	end, opts)
	map({ "n", "x" }, "<leader>od", function()
		vscode.call("workbench.action.files.openFolder")
	end, opts)
	-- call quitting commands
	map({ "n", "x" }, "<leader>qq", function()
		vscode.call("workbench.action.closeActiveEditor")
	end, opts)
	map({ "n", "x" }, "<leader>QQ", function()
		vscode.call("workbench.action.quit")
	end, opts)
	map({ "n", "x" }, "<leader>qa", function()
		vscode.call("workbench.action.closeAllEditors")
	end, opts)
	map({ "n", "x" }, "<leader>qo", function()
		vscode.call("workbench.action.closeOtherEditors")
	end, opts)
	map({ "n", "x" }, "<leader>qu", function()
		vscode.call("workbench.action.closeUnmodifiedEditors")
	end, opts)
	map("n", "<leader>qw", function()
		vscode.call("workbench.action.files.saveFiles")
		vscode.call("_wait", { args = { 500 } })
		vscode.call("workbench.action.quit")
	end, opts)
	-- quick comments
	map("n", "<leader>/", "gcc", vim.tbl_deep_extend("force", opts, { remap = true }))
	map("x", "<leader>/", "gc", vim.tbl_deep_extend("force", opts, { remap = true }))
	-- navigate within insert mode
	map("i", "<C-h>", "<Left>", opts)
	map("i", "<C-l>", "<Right>", opts)
	map("i", "<C-j>", "<Down>", opts)
	map("i", "<C-k>", "<Up>", opts)
	map("n", "<leader>x", function()
		vscode.call("workbench.view.extensions")
	end, opts)
	-- hack to run lazygit
	map("n", "<leader>G", function()
		vscode.call("workbench.action.toggleMaximizedPanel")
		vscode.call("terminal.focus")
		vscode.call("_wait", { args = { 500 } })
		vscode.call("workbench.action.terminal.sendSequence", { args = { text = "lazygit\r" } })
	end, opts)
	--saving
	map("n", "<leader>w", function()
		vscode.call("workbench.action.files.save")
	end, opts)
	map("n", "<leader>W", function()
		vscode.call("workbench.action.files.saveFiles")
	end, opts)
	map("n", "<leader>wa", function()
		vscode.call("workbench.action.files.saveAs")
	end, opts)
	-- search related
	map("n", "<leader>s", function()
		vscode.call("workbench.action.findInFiles")
	end, opts)
	map("n", "<leader>r", function()
		vscode.call("workbench.action.replaceInFiles")
	end, opts)
	-- clear vscode notifications
	map("n", "<leader>d", function()
		vscode.call("notifications.clearAll")
	end, opts)
	-- vscode local AI basic cotrols
	map("n", "<C-l>", function()
		vscode.call("workbench.view.extension.continue")
	end, opts)
	map("x", "<leader>ll", function()
		vscode.call("continue.focusContinueInputWithoutClear")
	end, opts)
	map("n", "<leader>c", function()
		vscode.call("continue.toggleTabAutocompleteEnabled")
	end, opts)
	-- folding
	map("n", "<leader>fa", function()
		vscode.call("editor.foldAll")
	end, opts)
	map("n", "<leader>fu", function()
		vscode.call("editor.unfoldAll")
	end, opts)
	map("n", "<leader>ff", function()
		vscode.call("editor.toggleFold")
	end, opts)
	map("n", "<leader>fr", function()
		vscode.call("editor.toggleFoldRecursively")
	end, opts)
	map("n", "<leader>fe", function()
		vscode.call("editor.toggleFoldExcept")
	end, opts)
	map("n", "<leader>f1", function()
		vscode.call("editor.foldLevel1")
	end, opts)
	map("n", "<leader>f2", function()
		vscode.call("editor.foldLevel2")
	end, opts)
	map("n", "<leader>f3", function()
		vscode.call("editor.foldLevel3")
	end, opts)
	map("n", "<leader>f4", function()
		vscode.call("editor.foldLevel4")
	end, opts)
	map("n", "<leader>f5", function()
		vscode.call("editor.foldLevel5")
	end, opts)
	map("n", "<leader>f6", function()
		vscode.call("editor.foldLevel6")
	end, opts)
	map("n", "<leader>f7", function()
		vscode.call("editor.foldLevel7")
	end, opts)
end

return M

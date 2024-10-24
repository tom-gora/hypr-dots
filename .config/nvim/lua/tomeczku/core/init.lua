-- vim options
require("tomeczku.core.vim_opts")
-- bootstrap lazy.nvim
require("tomeczku.core.bootstrap_lazy")
-- my hl groups overrides
require("tomeczku.core.highlights")
-- my user commands
require("tomeczku.core.user_commands")
if not vim.g.vscode then
	-- keymaps
	require("tomeczku.core.keymaps")
	-- winZap
	require("tomeczku.core.winZap")
	-- bring int autocommands
	require("tomeczku.core.autocommands")
	-- get statuslinme
	require("tomeczku.core.custom_statusline")
	-- miscellaneous
	require("tomeczku.core.misc")
elseif vim.g.vscode == 1 then
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
	local vs_code_things = require("tomeczku.vs_code")
	local vscode = require("vscode")
	-- fix notifications
	vim.notify = vscode.notify
	-- setup autocommands to still work in vscode
	vs_code_things.vscode_other.autocommands()
	-- keybinds triggered from nvim to avoid building complex when sections in vscodevscode-neovim
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
	-- linewise selection
	map({ "n", "x" }, "<leader><leader>", "V", opts)
	-- my custom shite
	map("n", "gz", "<cmd>MultiplyLineWithIndexing<cr>", opts)
	map("x", "gz", ":<c-u>ApplyIndexingOverSelection<cr>", opts)
	-- call opening file tree from editor
	map("n", "<leader>e", vs_code_things.vscode_other.focus_file_explorer, opts)
	-- call opening commands
	map({ "n", "x" }, "<leader>oc", vs_code_things.vscode_other.open.last_closed, opts)
	map({ "n", "x" }, "<leader>or", vs_code_things.vscode_other.open.open_recent, opts)
	map({ "n", "x" }, "<leader>oo", vs_code_things.vscode_other.open.quick_open, opts)
	map({ "n", "x" }, "<leader>on", vs_code_things.vscode_other.open.new_untitled_file, opts)
	map({ "n", "x" }, "<leader>od", vs_code_things.vscode_other.open.open_folder, opts)
	-- call quitting commands
	map({ "n", "x" }, "<leader>qq", vs_code_things.vscode_other.open.close_active_editor, opts)
	map({ "n", "x" }, "<leader>QQ", vs_code_things.vscode_other.open.quit, opts)
	map({ "n", "x" }, "<leader>qa", vs_code_things.vscode_other.open.close_all_editors, opts)
	map({ "n", "x" }, "<leader>qo", vs_code_things.vscode_other.open.close_other_editors, opts)
	map({ "n", "x" }, "<leader>qu", vs_code_things.vscode_other.open.close_unmodified_editors, opts)
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
	map("n", "<leader>x", vs_code_things.vscode_other.open.extensions, opts)
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
	map("n", "<leader>f", function()
		vscode.call("workbench.action.findInFiles")
	end, opts)
	map("n", "<leader>r", function()
		vscode.call("workbench.action.replaceInFiles")
	end, opts)
	map("n", "<leader>d", function()
		vscode.call("notifications.clearAll")
	end, opts)
	map("n", "<leader>S", function()
		vscode.call("supermaven.toggle")
	end, opts)

	-- disable ai on start

	vscode.call("_wait", { args = { 2000 } })
	vscode.call("supermaven.toggle")
end

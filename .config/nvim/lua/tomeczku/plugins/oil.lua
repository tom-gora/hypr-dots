if vim.g.vscode then
	return
end

local api = vim.api

local M, opts

local custom_oil_select_callback = function()
	local o = require("oil")
	local u = require("oil.util")
	-- regulat oil select
	o.select()
	-- handle directories
	local e = o.get_cursor_entry()
	if not _G._OilOpened or (e and u.is_directory(e) == true) then
		return
	end
	-- else tidy up after yourself
	api.nvim_win_close(_G._OilOpened, true)
	_G._OilOpened = nil
end

opts = {
	default_file_explorer = true,
	delete_to_trash = false,
	watch_for_changes = true,
	use_default_keymaps = false,
	is_hidden_file = function(name, _)
		return vim.startswith(name, ".")
	end,
	view_options = {
		natural_order = true,
	},
	preview_win = {
		scratch_buffer = true,
		limit_scratch_buffer = true,
	},
	keymaps = {
		["g?"] = "actions.show_help",
		["<C-a>"] = { desc = "Select item", callback = custom_oil_select_callback },
		["<Esc>"] = "actions.refresh",
		["<C-k>"] = "actions.parent",
		["<C-d>"] = "actions.open_cwd",
		["<C-p>"] = { "actions.preview", opts = { horizontal = true } },
		["~"] = false,
		["gs"] = "actions.change_sort",
		["gx"] = false,
		["<C-s>"] = "actions.toggle_hidden",
		["g\\"] = false,
	},
}

M = {
	"stevearc/oil.nvim",
	cond = vim.g.vscode == nil,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup(opts)
	end,
}

return M

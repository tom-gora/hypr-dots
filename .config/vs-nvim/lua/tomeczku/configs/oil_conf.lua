local M = {}
local api = vim.api
local map = vim.keymap.set

local custom_oil_close_callback = function()
	local a = require("oil.actions")
	local u = require("oil.util")
	-- prevent the rest of the func being called on nvim start
	-- when OIL, default explorer, is the only win and _OilOpened not been set yet
	-- or closing oil window when selecting a directory
	if u.is_oil_bufnr and _G._OilOpened ~= nil then
		map("n", "<leader>e", function()
			a.close.callback()
			api.nvim_win_close(_G._OilOpened, true)
			_G._OilOpened = nil
		end, {
			buffer = true,
		})
	end
end

local custom_oil_select_callback = function()
	local o = require("oil")
	local u = require("oil.util")
	-- regulat oil select
	o.select({
		{ vertical = true, split = "aboveleft" },
	})
	-- prevent the rest of the func being called on nvim start
	-- when OIL, default explorer, is the only win and _OilOpened not been set yet
	local e = o.get_cursor_entry()
	if not _G._OilOpened or (e and u.is_directory(e) == true) then
		return
	end
	-- after selecting the file  close oil split
	api.nvim_win_close(_G._OilOpened, true)
	_G._OilOpened = nil
end

M.init_function = function()
	api.nvim_create_autocmd("User", {
		group = api.nvim_create_augroup("OilModifications", { clear = true }),
		pattern = "OilEnter",
		callback = custom_oil_close_callback,
	})
end

M.dependencies = { "nvim-tree/nvim-web-devicons" }

M.opts = {
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
	keymaps = {
		["g?"] = "actions.show_help",
		["<C-a>"] = { desc = "Select item", callback = custom_oil_select_callback },
		["<Esc>"] = "actions.refresh",
		["<C-k>"] = "actions.parent",
		["<C-d>"] = "actions.open_cwd",
		["`"] = false,
		["~"] = false,
		["gs"] = "actions.change_sort",
		["gx"] = false,
		["<C-.>"] = "actions.toggle_hidden",
		["g\\"] = false,
	},
}

return M
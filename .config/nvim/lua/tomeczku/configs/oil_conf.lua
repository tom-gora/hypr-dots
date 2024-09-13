local M = {}

local float_max_width = function()
	-- width of the oil float is either 1/3 of the window or 35 cols to prevent it from being too small
	return math.max(math.floor(vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) / 3.5), 35)
end

local float_height = function()
	-- height of the float
	return math.floor(vim.api.nvim_win_get_height(vim.api.nvim_get_current_win()) - 2)
end

local float_offset = function()
	-- right side offset
	return vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) - (float_max_width() + 3)
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
		["<C-l>"] = "actions.select",
		["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
		["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
		["<C-t>"] = false,
		["<C-p>"] = "actions.preview",
		["<leader>e"] = { "actions.close", desc = "󰏇 Toggle Oil" },
		["<Esc>"] = "actions.refresh",
		["<C-h>"] = "actions.parent",
		["<C-d>"] = "actions.open_cwd",
		["`"] = false,
		["~"] = false,
		["gs"] = "actions.change_sort",
		["gx"] = false,
		["<C-.>"] = "actions.toggle_hidden",
		["g\\"] = false,
	},
	float = {
		preview_split = "below",
		padding = 1,
		override = function()
			return {
				style = "minimal",
				border = "rounded",
				relative = "editor",
				row = 1,
				col = float_offset(),
				width = float_max_width(),
				height = float_height(),
			}
		end,
	},
}

return M

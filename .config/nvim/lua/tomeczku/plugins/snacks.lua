if vim.g.vscode then
	return
end

local M, opts

opts = {
	styles = { lazygit = { border = "rounded" } },
	-- only enable selected
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = false },
	indent = { enabled = true },
	input = { enabled = false },
	lazygit = { enabled = true, opts = {
		style = "lazygit",
	} },
	picker = {
		enabled = true,
		layout = {
			cycle = false,
			preset = function()
				return vim.o.columns >= 106 and "ivy" or "right"
			end,
		},
		prompt = " ",
		matcher = { freecency = true },
		win = {
			input = {
				keys = {
					["<c-n>"] = { "history_forward", mode = { "i", "n" } },
					["<c-p>"] = { "history_back", mode = { "i", "n" } },
					["<c-c>"] = { "cancel", mode = "i" },
					["<CR>"] = { "confirm", mode = { "n", "i" } },
					["<c-a>"] = { "confirm", mode = { "n", "i" } },
					["<Esc>"] = "cancel",
					["<a-k>"] = { "select_and_prev", mode = { "i", "n" } },
					["<a-j>"] = { "select_and_next", mode = { "i", "n" } },
					["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
					["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
					["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
					["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
					["<a-a>"] = { "select_all", mode = { "n", "i" } },
					["<c-f>"] = { "preview_scroll_up", mode = { "i", "n" } },
					["<c-b>"] = { "preview_scroll_down", mode = { "i", "n" } },
					["<c-j>"] = { "list_down", mode = { "i", "n" } },
					["<c-k>"] = { "list_up", mode = { "i", "n" } },
					["<c-q>"] = { "qflist", mode = { "i", "n" } },
					["?"] = "toggle_help_input",
					["G"] = "list_bottom",
					["gg"] = "list_top",
					["j"] = "list_down",
					["k"] = "list_up",
					-- disabled default feature creeps ;]
					["/"] = false,
					["<c-g>"] = false, -- { "toggle_live", mode = { "i", "n" } },
					["<C-Down>"] = false,
					["<C-Up>"] = false,
					["<S-CR>"] = false,
					["<C-w>"] = false,
					["<Down>"] = false,
					["<S-Tab>"] = false,
					["<Tab>"] = false,
					["<Up>"] = false,
					["<a-d>"] = false, -- ? { "inspect", mode = { "n", "i" } },
					["<a-f>"] = false, -- { "toggle_follow", mode = { "i", "n" } },
					["<a-w>"] = false,
					["<c-d>"] = false,
					["<c-s>"] = false, -- { "edit_split", mode = { "i", "n" } },
					["<c-u>"] = false,
					["<c-v>"] = false, -- { "edit_vsplit", mode = { "i", "n" } },
					["<c-r>#"] = false, -- { "insert_alt", mode = "i" },
					["<c-r>%"] = false, -- { "insert_filename", mode = "i" },
					["<c-r><c-a>"] = false, -- { "insert_cWORD", mode = "i" },
					["<c-r><c-f>"] = false, -- { "insert_file", mode = "i" },
					["<c-r><c-l>"] = false, -- { "insert_line", mode = "i" },
					["<c-r><c-p>"] = false, -- { "insert_file_full", mode = "i" },
					["<c-r><c-w>"] = false, -- { "insert_cword", mode = "i" },
					["<c-w>H"] = false, -- "layout_left",
					["<c-w>J"] = false, -- "layout_bottom",
					["<c-w>K"] = false, -- "layout_top",
					["<c-w>L"] = false, -- "layout_right",
					["q"] = false,
				},
			},
		},
	},
	notifier = { enabled = false },
	quickfile = { enabled = false },
	scope = { enabled = false },
	scroll = { enabled = true },
	statuscolumn = { enabled = false },
	terminal = { enabled = true },
	words = { enabled = false },
	zen = {
		enabled = true,
		toggles = {
			dim = false,
			git_signs = true,
		},
		show = {
			statusline = false,
			tabline = false,
		},
	},
}

M = {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = opts,
}

return M

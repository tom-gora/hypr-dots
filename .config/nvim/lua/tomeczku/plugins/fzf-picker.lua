if vim.g.vscode then
	return
end

local M, opts = {}, {}
local preset, global_winopts, fzf_colors, fzf_opts, keymap, picker_opts

--
-- DECLARATIIVE SECTION
--
preset = { "ivy" }

global_winopts = {
	fullscreen = false,
	backdrop = 0,
	border = "solid",
	title_pos = "right",
	preview = {
		border = { "░", " ", " ", " ", " ", " ", "░", "░" },
		title = false,
	},
	on_create = function()
		vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
		vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
	end,
}

fzf_opts = {
	["--scrollbar"] = "█",
	["--separator"] = "🬋",
}

fzf_colors = {
	true,
	bg = "-1",
	gutter = "-1",
}

keymap = {
	builtin = {
		["<M-Esc>"] = false,
		["<M-m>"] = "hide",
		["<F1>"] = "toggle-help",
		["<F2>"] = false,
		["<M-f>"] = "toggle-fullscreen",
		-- Only valid with the 'builtin' previewer
		["<F3>"] = false,
		["<M-p>"] = "toggle-preview",
		["<F5>"] = false,
		["<F6>"] = false,
		["<F7>"] = false,
		["<F8>"] = false,
		["<F9>"] = false,
		["<S-Left>"] = false,
		["<S-down>"] = false,
		["<S-up>"] = false,
		["<M-S-down>"] = false,
		["<M-S-up>"] = false,
		["<M-r>"] = "preview-reset",
		["<M-j>"] = "preview-half-page-down",
		["<M-k>"] = "preview-half-page-up",
	},
	fzf = {
		-- fzf '--bind=' options
		-- false,        -- uncomment to inherit all the below in your custom config
		true,
		["ctrl-a"] = "accept-non-empty",
		["Esc"] = "abort",
		["ctrl-u"] = "unix-line-discard",
		["ctrl-e"] = false,
		["alt-a"] = "toggle-all",
		["alt-g"] = "first",
		["alt-G"] = "last",
		["ctrl-j"] = "down",
		["ctrl-k"] = "up",
	},
}

pickers_opts = {
	-- make grep picker consistent in look with the rest
	grep = {
		prompt = "󱩾 🯛",
		winopts = {
			fullscreen = false,
			height = 0.4,
			preview = { layout = "horizontal" },
		},
		file_icons = true,
	},
	files = {
		prompt = "󰱽 🯛",
	},
	git = {
		prompt = "󰊢 🯛",
	},
	files = {
		prompt = "󰱽 🯛",
	},
	args = {
		prompt = "() 🯛",
	},
	oldfiles = {
		prompt = "󰋚 🯛",
	},
	buffers = {
		prompt = " 🯛",
	},
	lines = {
		prompt = " 🯛",
	},
	tags = {
		prompt = " 🯛",
	},
	keyboard = {
		prompt = " 🯛",
	},
	lsp = {
		prompt = " 🯛",
	},
	diagnostics = {
		prompt = "󱈸 🯛",
	},
	marks = {
		prompt = " 🯛",
	},
	zoxide = {
		prompt = " 🯛",
	},
}
-- put config together
opts[1] = preset
opts["winopts"] = global_winopts
opts["fzf_colors"] = fzf_colors
opts["fzf_opts"] = fzf_opts
opts["keymap"] = keymap
opts = vim.tbl_deep_extend("force", opts, pickers_opts)

-- plugin spec
M = {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup(opts)
	end,
}

return M

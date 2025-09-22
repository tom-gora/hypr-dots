if vim.g.vscode then
end

local M, opts = {}, {}
local preset, global_winopts, fzf_colors, fzf_opts, keymap, pickers_opts

-- on selection of a highlight group, copy its colors to the clipboard
---@param arg string[]
---@return void
local handleHlGroupPick = function(arg)
	local dec_to_hex_color = function(color)
		if type(color) ~= "string" or string.match(color, "^#") == nil then
			return string.format("#%06X", color)
		end
		return tostring(color)
	end
	local hl = vim.api.nvim_get_hl(0, { name = arg[1] })
	local formatted_lines = {}

	for key, value in pairs(hl) do
		if key == "fg" or key == "bg" or key == "sp" then
			local formatted_value = dec_to_hex_color(value)
			table.insert(formatted_lines, string.format("%s: %s", key, formatted_value))
		elseif key == "link" then
			local linked = vim.api.nvim_get_hl(0, { name = value })
			for lkey, lvalue in pairs(linked) do
				if lkey == "fg" or lkey == "bg" or lkey == "sp" then
					local formatted_value = dec_to_hex_color(lvalue)
					table.insert(formatted_lines, string.format("%s: %s", lkey, formatted_value))
				end
			end
		end
	end

	if #formatted_lines < 1 then
		vim.notify(
			"No colors found for highlight group '" .. arg[1] .. "'.",
			vim.log.levels.WARN,
			{ title = "Highlight Info" }
		)
		return
	end

	local final_string = table.concat(formatted_lines, "\n")

	vim.fn.setreg("+", final_string)

	vim.notify(
		"Highlight info for '" .. arg[1] .. "' copied to + register:\n" .. final_string,
		vim.log.levels.INFO,
		{ title = "Highlight Info" }
	)
end
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
	highlights = {
		prompt = " 🯛",
		-- NOTE: Cannot inject custom action?
		actions = {
			["enter"] = handleHlGroupPick,
			["Ctrl-a"] = handleHlGroupPick,
		},
	},
	files = {
		prompt = "󰱽 🯛",
		sort_lastused = true,
	},
	git = {
		prompt = "󰊢 🯛",
		sort_lastused = true,
	},
	args = {
		prompt = "() 🯛",
	},
	oldfiles = {
		prompt = "󰋚 🯛",
		sort_lastused = true,
	},
	buffers = {
		prompt = " 🯛",
		sort_lastused = true,
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

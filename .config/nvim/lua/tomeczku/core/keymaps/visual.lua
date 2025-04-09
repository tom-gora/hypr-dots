local M, h = {}, require("tomeczku.core.keymaps.helpers")

M = {
	--  NOTE:
	--          ░██████╗░░█████╗░██╗░░░░░
	--          ██╔═══██╗██╔══██╗██║░░░░░
	--          ██║██╗██║██║░░██║██║░░░░░
	--          ╚██████╔╝██║░░██║██║░░░░░
	--          ░╚═██╔═╝░╚█████╔╝███████╗
	--          ░░░╚═╝░░░░╚════╝░╚══════╝
	--
	-- toggle comment line in visual mode
	["<leader>/"] = {
		"gc",
		h.setOpts({ desc = "which_key_ignore", remap = true }),
	},
	--
	-- my index fixing command
	["gz"] = { ":<c-u>ApplyIndexingOverSelection<cr>", h.setOpts({ desc = "Index Lines Inside Selection" }) },

	--
	-- don't leave visual mode when changing indent
	[">"] = { ">gv", h.setOpts() },
	["<"] = { "<gv", h.setOpts() },
	--
	--  NOTE:
	--         ██████╗░██╗░░░░░██╗░░░██╗░██████╗░██╗███╗░░██╗░██████╗
	--         ██╔══██╗██║░░░░░██║░░░██║██╔════╝░██║████╗░██║██╔════╝
	--         ██████╔╝██║░░░░░██║░░░██║██║░░██╗░██║██╔██╗██║╚█████╗░
	--         ██╔═══╝░██║░░░░░██║░░░██║██║░░╚██╗██║██║╚████║░╚═══██╗
	--         ██║░░░░░███████╗╚██████╔╝╚██████╔╝██║██║░╚███║██████╔╝
	--         ╚═╝░░░░░╚══════╝░╚═════╝░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░
	--
	--
	-- whichkey search and replace section for visual selection
	["<leader>r"] = { " Replace" },
	["<leader>rs"] = { "<cmd>SearchReplaceVisualSelection<cr>", h.setOpts({ desc = "Replace the Selection" }) },
	["<leader>rii"] = {
		"<cmd>SearchReplaceInsideVisualSelection true<cr>",
		h.setOpts({ desc = "Inside Selection Ignore Case" }),
	},
	["<leader>rip"] = {
		"<cmd>SearchReplaceInsideVisualSelection false<cr>",
		h.setOpts({ desc = "Inside Selection Preserve Case" }),
	},
	--
	-- silicon-nvim
	["<leader>s"] = { " Silicon" },
	["<leader>sc"] = { "<cmd>lua require('nvim-silicon').clip()<cr>", h.setOpts({ desc = " -> To Clipboard" }) },
	["<leader>sf"] = { "<cmd>lua require('nvim-silicon').file()<cr>", h.setOpts({ desc = " -> To File" }) },
	["<leader>ss"] = { "<cmd>lua require('nvim-silicon').shoot()<cr>", h.setOpts({ desc = "  -> To Both" }) },
	--
	-- textcase case toggler for visual mode
	["<leader>~"] = { "󰬴 TextCase" },
	["<leader>~u"] = {
		"<cmd>lua require('textcase').current_word('to_upper_case')<CR>",
		h.setOpts({ desc = "Selection to Upper Case" }),
	},
	["<leader>~l"] = {
		"<cmd>lua require('textcase').current_word('to_lower_case')<CR>",
		h.setOpts({ desc = "Selection to Lower Case" }),
	},
	["<leader>~s"] = {
		"<cmd>lua require('textcase').current_word('to_snake_case')<CR>",
		h.setOpts({ desc = "Selection to Snake Case" }),
	},
	["<leader>~d"] = {
		"<cmd>lua require('textcase').current_word('to_dash_case')<CR>",
		h.setOpts({ desc = "Selection to Dash Case" }),
	},
	["<leader>~k"] = {
		"<cmd>lua require('textcase').current_word('to_dot_case')<CR>",
		h.setOpts({ desc = "Selection to Dot Case" }),
	},
	["<leader>~f"] = {
		"<cmd>lua require('textcase').current_word('to_phrase_case')<CR>",
		h.setOpts({ desc = "Selection to Phrase Case" }),
	},
	["<leader>~c"] = {
		"<cmd>lua require('textcase').current_word('to_camel_case')<CR>",
		h.setOpts({ desc = "Selection to Camel Case" }),
	},
	["<leader>~p"] = {
		"<cmd>lua require('textcase').current_word('to_pascal_case')<CR>",
		h.setOpts({ desc = "Selection to Pascal Case" }),
	},
	["<leader>~t"] = {
		"<cmd>lua require('textcase').current_word('to_title_case')<CR>",
		h.setOpts({ desc = "Selection to Title Case" }),
	},
	["<leader>~w"] = {
		"<cmd>lua require('textcase').current_word('to_path_case')<CR>",
		h.setOpts({ desc = "Selection to Path Case" }),
	},
}

return M

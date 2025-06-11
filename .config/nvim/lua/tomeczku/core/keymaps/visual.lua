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
		function()
			require("textcase").visual("to_upper_case")
		end,
		h.setOpts({ desc = "Selection to Upper Case" }),
	},
	["<leader>~l"] = {
		function()
			require("textcase").visual("to_lower_case")
		end,
		h.setOpts({ desc = "Selection to Lower Case" }),
	},
	["<leader>~s"] = {
		function()
			require("textcase").visual("to_snake_case")
		end,
		h.setOpts({ desc = "Selection to Snake Case" }),
	},
	["<leader>~k"] = {
		function()
			require("textcase").visual("to_dash_case")
		end,
		h.setOpts({ desc = "Selection to Kebab Case" }),
	},
	["<leader>~d"] = {
		function()
			require("textcase").visual("to_dot_case")
		end,
		h.setOpts({ desc = "Selection to Dot Case" }),
	},
	["<leader>~f"] = {
		function()
			require("textcase").visual("to_phrase_case")
		end,
		h.setOpts({ desc = "Selection to Phrase Case" }),
	},
	["<leader>~c"] = {
		function()
			require("textcase").visual("to_camel_case")
		end,
		h.setOpts({ desc = "Selection to Camel Case" }),
	},
	["<leader>~p"] = {
		function()
			require("textcase").visual("to_pascal_case")
		end,
		h.setOpts({ desc = "Selection to Pascal Case" }),
	},
	["<leader>~t"] = {
		function()
			require("textcase").visual("to_title_case")
		end,
		h.setOpts({ desc = "Selection to Title Case" }),
	},
	["<leader>~w"] = {
		function()
			require("textcase").visual("to_path_case")
		end,
		h.setOpts({ desc = "Selection to Path Case" }),
	},
}

return M

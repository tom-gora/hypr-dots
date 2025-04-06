local M, ignore, silicon = {}, { desc = "which_key_ignore" }, require("nvim-silicon")

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
		vim.tbl_deep_extend("force", ignore, { remap = true }),
	},
	--
	-- my index fixing command
	["gz"] = { ":<c-u>ApplyIndexingOverSelection<cr>", { desc = "Index Lines Inside Selection" } },
	--
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
	["<leader>rs"] = { "<cmd>SearchReplaceVisualSelection<cr>", { desc = "Replace the Selection" } },
	["<leader>rii"] = { "<cmd>SearchReplaceInsideVisualSelection true<cr>", { desc = "Inside Selection Ignore Case" } },
	["<leader>rip"] = {
		"<cmd>SearchReplaceInsideVisualSelection false<cr>",
		{ desc = "Inside Selection Preserve Case" },
	},
	--
	-- silicon-nvim
	["<leader>s"] = { " Silicon" },
	["<leader>sc"] = { "<cmd>lua require('nvim-silicon').clip()<cr>", { desc = " -> To Clipboard" } },
	["<leader>sf"] = { "<cmd>lua require('nvim-silicon').file()<cr>", { desc = " -> To File" } },
	["<leader>ss"] = { "<cmd>lua require('nvim-silicon').shoot()<cr>", { desc = "  -> To Both" } },
	--
	-- textcase case toggler for visual mode
	["<leader>~"] = { "󰬴 TextCase" },
	["<leader>~u"] = {
		"<cmd>lua require('textcase').current_word('to_upper_case')<CR>",
		{ desc = "Selection to Upper Case" },
	},
	["<leader>~l"] = {
		"<cmd>lua require('textcase').current_word('to_lower_case')<CR>",
		{ desc = "Selection to Lower Case" },
	},
	["<leader>~s"] = {
		"<cmd>lua require('textcase').current_word('to_snake_case')<CR>",
		{ desc = "Selection to Snake Case" },
	},
	["<leader>~d"] = {
		"<cmd>lua require('textcase').current_word('to_dash_case')<CR>",
		{ desc = "Selection to Dash Case" },
	},
	["<leader>~k"] = {
		"<cmd>lua require('textcase').current_word('to_dot_case')<CR>",
		{ desc = "Selection to Dot Case" },
	},
	["<leader>~f"] = {
		"<cmd>lua require('textcase').current_word('to_phrase_case')<CR>",
		{ desc = "Selection to Phrase Case" },
	},
	["<leader>~c"] = {
		"<cmd>lua require('textcase').current_word('to_camel_case')<CR>",
		{ desc = "Selection to Camel Case" },
	},
	["<leader>~p"] = {
		"<cmd>lua require('textcase').current_word('to_pascal_case')<CR>",
		{ desc = "Selection to Pascal Case" },
	},
	["<leader>~t"] = {
		"<cmd>lua require('textcase').current_word('to_title_case')<CR>",
		{ desc = "Selection to Title Case" },
	},
	["<leader>~w"] = {
		"<cmd>lua require('textcase').current_word('to_path_case')<CR>",
		{ desc = "Selection to Path Case" },
	},
}

return M

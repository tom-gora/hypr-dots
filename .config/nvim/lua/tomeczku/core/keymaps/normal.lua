local M, h, ignore = {}, require("tomeczku.core.keymaps.helpers"), { desc = "which_key_ignore" }

M = {
	--  NOTE:
	--          ░██████╗░░█████╗░██╗░░░░░
	--          ██╔═══██╗██╔══██╗██║░░░░░
	--          ██║██╗██║██║░░██║██║░░░░░
	--          ╚██████╔╝██║░░██║██║░░░░░
	--          ░╚═██╔═╝░╚█████╔╝███████╗
	--          ░░░╚═╝░░░░╚════╝░╚══════╝
	--
	-- fix polluting clipboard with non cutting operations with blackhole register
	["ciw"] = { '"_ciw', ignore },
	["caw"] = { '"_caw', ignore },
	--
	-- select all buf lines quickly
	["<leader>a"] = { "ggVG", ignore },
	--
	-- yank the line without newline char
	["<S-y>"] = { "mQ0y$`Q", ignore },
	--
	-- toggle comment line in normal mode
	["<leader>/"] = { "gcc", vim.tbl_deep_extend("force", ignore, { remap = true }) },
	--
	-- clear search highlights
	["<Esc>"] = { "<cmd>noh<cr>", ignore },
	["jn"] = { "<cmd>noh<cr>", ignore },
	--
	-- write buffer
	["<leader>w"] = { "<cmd>w<cr>", ignore },
	--
	-- write all bufs
	["<leader>W"] = { "<cmd>wa<cr>", ignore },
	--
	-- alternative close window closer to normal leader region than regular q
	["<leader>vc"] = { "<cmd>lua vim.cmd('wincmd q')<cr>", { desc = "Quit a window" } },
	--
	-- neovim help picker
	["<leader>?"] = { "<cmd>lua Snacks.picker.help()<cr>", { desc = "󰋗 Help" } },
	--
	-- my index fixing command
	["gz"] = { "<cmd>MultiplyLineWithIndexing<cr>", { desc = "Multiply Line with Indexing" } },
	--
	--  NOTE:
	--         ██████╗░██╗░░░░░██╗░░░██╗░██████╗░██╗███╗░░██╗░██████╗
	--         ██╔══██╗██║░░░░░██║░░░██║██╔════╝░██║████╗░██║██╔════╝
	--         ██████╔╝██║░░░░░██║░░░██║██║░░██╗░██║██╔██╗██║╚█████╗░
	--         ██╔═══╝░██║░░░░░██║░░░██║██║░░╚██╗██║██║╚████║░╚═══██╗
	--         ██║░░░░░███████╗╚██████╔╝╚██████╔╝██║██║░╚███║██████╔╝
	--         ╚═╝░░░░░╚══════╝░╚═════╝░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░
	--
	-- toggle oil pane
	["<leader>e"] = {
		h.toggleOil,
		{ desc = "󰏇 Toggle Oil" },
	},
	--
	-- jump between bufs back and forth
	-- use barbar with native nvim fallback
	["<S-l>"] = {
		h.nextBufWithFallback,
		vim.tbl_deep_extend("force", ignore, { expr = true }),
	},
	["<S-h>"] = {
		h.prevBufWithFallback,
		vim.tbl_deep_extend("force", ignore, { expr = true }),
	},
	--
	-- AI
	["<leader>S"] = { "<cmd>ToggleAi<cr>", { desc = " Toggle Supermaven" } },
	--
	-- zen from Snacks
	["<leader>z"] = { "<cmd>lua Snacks.zen()<cr>", { desc = " Toggle Zen Mode" } },

	--
	-- whichkey neovim section
	["<leader>n"] = { " NeoVim" },
	["<leader>ns"] = { "<cmd>ClearSwap<cr>", { desc = "Clear the Swap" } },
	["<leader>nl"] = { "<cmd>Lazy<cr>", { desc = "Open Lazy" } },
	["<leader>nm"] = { "<cmd>Mason<cr>", { desc = "Open Mason" } },
	["<leader>nc"] = { "<cmd>checkhealth<cr>", { desc = "Do Checkhealth" } },
	["<leader>nh"] = { "<cmd>lua Snacks.picker.highlights()<cr>", { desc = "Look up HL Groups" } },
	["<leader>nk"] = { "<cmd>lua Snacks.picker.keymaps()<cr>", { desc = "Look up Key Mappings" } },
	["<leader>nd"] = { "<cmd>lua require('notify').dismiss()<cr>", { desc = "Dismiss Notifications" } },
	--
	-- whichkey moveto section
	["<leader>m"] = { " Move To" },
	["<leader>mb"] = { "<cmd>lua Snacks.picker.buffers()<cr>", { desc = "Find Buffers" } },
	-- # Goto buffer in position...
	["<leader>m1"] = { "<Cmd>BufferGoto 1<cr>", { desc = "Move to Buffer Index 1" } },
	["<leader>m2"] = { "<Cmd>BufferGoto 2<cr>", { desc = "Move to Buffer Index 2" } },
	["<leader>m3"] = { "<Cmd>BufferGoto 3<cr>", { desc = "Move to Buffer Index 3" } },
	["<leader>m4"] = { "<Cmd>BufferGoto 4<cr>", { desc = "Move to Buffer Index 4" } },
	["<leader>m5"] = { "<Cmd>BufferGoto 5<cr>", { desc = "Move to Buffer Index 5" } },
	["<leader>m6"] = { "<Cmd>BufferGoto 6<cr>", { desc = "Move to Buffer Index 6" } },
	["<leader>m7"] = { "<Cmd>BufferGoto 7<cr>", { desc = "Move to Buffer Index 7" } },
	["<leader>m8"] = { "<Cmd>BufferGoto 8<cr>", { desc = "Move to Buffer Index 8" } },
	["<leader>m9"] = { "<Cmd>BufferGoto 9<cr>", { desc = "Move to Buffer Index 9" } },
	["<leader>m0"] = { "<Cmd>BufferLast<cr>", { desc = "Move to Last Buffer" } },
	--
	-- git stuff
	["<leader>g"] = { "󰊢 Git" },
	["<leader>gg"] = { "<cmd>lua Snacks.lazygit.open()<cr>", { desc = "󰊢 LazyGit" } },
	["<leader>gl"] = { "<cmd>lua Snacks.lazygit.log()<cr>", { desc = "LazyGit Logs" } },
	["<leader>gL"] = {
		"<cmd>lua Snacks.lazygit.log({args = { 'log', '-sm', 'full' }})<cr>",
		{ desc = "LazyGit Logs Graph" },
	},
	["<leader>gs"] = { "<cmd>Gitsigns<cr>", { desc = "Gitsigns Picker" } },
	--
	-- general find stuff pickers from Snacks
	["<leader>f"] = { " Find" },
	["<leader>ff"] = { "<cmd>lua Snacks.picker.files()<cr>", { desc = "Find Files" } },
	["<leader>fw"] = { "<cmd>lua Snacks.picker.grep_word()<cr>", { desc = "Find Word Under Cursor/Selection" } },
	["<leader>fo"] = { "<cmd>lua Snacks.picker.grep_buffers()<cr>", { desc = "Find in Opened Files" } },
	["<leader>fb"] = { "<cmd>lua Snacks.picker.lines()<cr>", { desc = "Current Buffer Lines" } },
	["<leader>fd"] = { "<cmd>lua Snacks.picker.grep()<cr>", { desc = "Find in CWD" } },
	["<leader>fa"] = {
		"<cmd>lua Snacks.picker.files({hidden = true})<cr>",
		{ desc = "Find All Files (hidden etc.)" },
	},
	["<leader>fp"] = { "<cmd>lua Snacks.picker.pickers()<cr>", { desc = "Recent Pickers" } },
	["<leader>fh"] = { "<cmd>lua Snacks.picker.command_history()<cr>", { desc = "Command History" } },
	["<leader>fu"] = { "<cmd>lua Snacks.picker.undo()<cr>", { desc = "Find in Undo Tree" } },
	["<leader>fc"] = { "<cmd>lua Snacks.picker.todo_comments()<cr>", { desc = "Find Todo Comments" } },
	["<leader>fv"] = { "<cmd>lua Snacks.picker.cliphist()<cr>", { desc = "Find in OS Clipboard History." } },
	--
	-- terminal
	["<C-t>"] = { "<cmd>lua  Snacks.terminal.toggle()<CR>", { desc = "Toggle terminal" } },
	--
	-- whichkey replace section for normal mode
	["<leader>r"] = { "󰛔 Replace" },
	["<leader>rw"] = { "Replace Cword" },
	["<leader>rr"] = { "Replace Init" },
	["<leader>rwi"] = { "<cmd>SearchReplaceCword true<cr>", { desc = "Replace Cword Ignore Case" } },
	["<leader>rwp"] = { "<cmd>SearchReplaceCword false<cr>", { desc = "Replace Cword Preserve Case" } },
	["<leader>rri"] = { "<cmd>SearchReplaceInit true<cr>", { desc = "Replace Ignore Case" } },
	["<leader>rrp"] = { "<cmd>SearchReplaceInit false<cr>", { desc = "Replace Preserve Case" } },
	--
	-- lsp section (configured in the lsp congfig)
	["<leader>l"] = { "  LSP" },
	--
	-- quickfix List with quicker
	["<leader>c"] = { " QuickFix List" },
	["<leader>cc"] = { "<cmd>lua require('quicker').toggle()<cr>", { desc = "Toggle QuickFix List" } },
	["<leader>cx"] = { h.clearQuickFixList, { desc = "Force Clear QuickFix List" } },
	--
	-- tmux navigator keymaps
	["<c-h>"] = { "<cmd>TmuxNavigateLeft<cr>", { silent = true, noremap = true } },
	["<c-j>"] = { "<cmd>TmuxNavigateDown<cr>", { silent = true, noremap = true } },
	["<c-k>"] = { "<cmd>TmuxNavigateUp<cr>", { silent = true, noremap = true } },
	["<c-l>"] = { "<cmd>TmuxNavigateRight<cr>", { silent = true, noremap = true } },
	--
	-- trouble lsp stuff and diagnostics
	["<leader>ll"] = {
		"<cmd>Trouble diagnostics toggle <cr>",
		{ desc = "Trouble LSP Diagnostics" },
	},
	["<leader>lb"] = {
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		{ desc = "Trouble LSP Buffer Diagnostics" },
	},
	["<leader>ld"] = { "<cmd>Trouble lsp_definitions<cr>", { desc = "Trouble LSP Definitions" } },
	["<leader>lD"] = { "<cmd>Trouble lsp_type_definitions<cr>", { desc = "Trouble LSP Type Definitions" } },
	["<leader>ls"] = { "<cmd>Trouble symbols toggle <cr>", { desc = "Trouble Symbols" } },
	["<leader>lS"] = { "<cmd>Trouble document_symbols toggle <cr>", { desc = "Trouble Document Symbols" } },
	["<leader>lr"] = { "<cmd>Trouble lsp_references toggle win.position=right<cr>", { desc = "Trouble References" } },
	["<leader>lI"] = {
		"<cmd>Trouble lsp_implementations win.position=right<cr>",
		{ desc = "Trouble Implementations" },
	},
	["<leader>lq"] = { "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble Quickfix List" } },
	--
	-- textcase case toggler for normal mode
	["<leader>~"] = { "󰬴 TextCase" },
	["<leader>~u"] = {
		"<cmd>lua require('textcase').current_word('to_upper_case')<CR>",
		{ desc = "Current Word to Upper Case" },
	},
	["<leader>~l"] = {
		"<cmd>lua require('textcase').current_word('to_lower_case')<CR>",
		{ desc = "Current Word to Lower Case" },
	},
	["<leader>~s"] = {
		"<cmd>lua require('textcase').current_word('to_snake_case')<CR>",
		{ desc = "Current Word to Snake Case" },
	},
	["<leader>~d"] = {
		"<cmd>lua require('textcase').current_word('to_dash_case')<CR>",
		{ desc = "Current Word to Dash Case" },
	},
	["<leader>~k"] = {
		"<cmd>lua require('textcase').current_word('to_dot_case')<CR>",
		{ desc = "Current Word to Dot Case" },
	},
	["<leader>~f"] = {
		"<cmd>lua require('textcase').current_word('to_phrase_case')<CR>",
		{ desc = "Current Word to Phrase Case" },
	},
	["<leader>~c"] = {
		"<cmd>lua require('textcase').current_word('to_camel_case')<CR>",
		{ desc = "Current Word to Camel Case" },
	},
	["<leader>~p"] = {
		"<cmd>lua require('textcase').current_word('to_pascal_case')<CR>",
		{ desc = "Current Word to Pascal Case" },
	},
	["<leader>~t"] = {
		"<cmd>lua require('textcase').current_word('to_title_case')<CR>",
		{ desc = "Current Word to Title Case" },
	},
	["<leader>~w"] = {
		"<cmd>lua require('textcase').current_word('to_path_case')<CR>",
		{ desc = "Current Word to Path Case" },
	},
	-- LSP Rename mappings
	["<leader>~U"] = {
		"<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>",
		{ desc = "LSP Rename to Upper Case" },
	},
	["<leader>~L"] = {
		"<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>",
		{ desc = "LSP Rename to Lower Case" },
	},
	["<leader>~S"] = {
		"<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>",
		{ desc = "LSP Rename to Snake Case" },
	},
	["<leader>~D"] = {
		"<cmd>lua require('textcase').lsp_rename('to_dash_case')<CR>",
		{ desc = "LSP Rename to Dash Case" },
	},
	["<leader>~K"] = {
		"<cmd>lua require('textcase').lspRename('to_dot_case')<CR>",
		{ desc = "LSP Rename to Dot Case" },
	},
	["<leader>~F"] = {
		"<cmd>lua require('textcase').lsp_rename('to_phrase_case')<CR>",
		{ desc = "LSP Rename to Phrase Case" },
	},
	["<leader>~C"] = {
		"<cmd>lua require('textcase').lspRename('to_camel_case')<CR>",
		{ desc = "LSP Rename to Camel Case" },
	},
	["<leader>~P"] = {
		"<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
		{ desc = "LSP Rename to Pascal Case" },
	},
	["<leader>~T"] = {
		"<cmd>lua require('textcase').lsp_rename('to_title_case')<CR>",
		{ desc = "LSP Rename to Title Case" },
	},
	["<leader>~W"] = {
		"<cmd>lua require('textcase').lspRename('to_path_case')<CR>",
		{ desc = "LSP Rename to Path Case" },
	},
}

return M

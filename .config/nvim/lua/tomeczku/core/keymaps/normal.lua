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
	-- fix polluting clipboard with non cutting operations with blackhole register
	["ciw"] = { '"_ciw', h.setOpts({ desc = "ignore" }) },
	["caw"] = { '"_caw', h.setOpts({ desc = "ignore" }) },
	--
	-- yank all buf lines quickly
	["<leader>a"] = { h.yankAll, h.setOpts({ desc = "ignore" }) },
	--
	-- delete all buf lines quickly
	["<leader>dd"] = { h.clearAll, h.setOpts({ desc = "ignore" }) },
	--
	["<S-Y>"] = { h.yankFromCursorToEOL, h.setOpts({ desc = "ignore" }) },
	--
	-- yank the line without newline char
	["<S-y>"] = { "mQ0y$`Q", h.setOpts({ desc = "ignore" }) },
	--
	-- toggle comment line in normal mode
	["<leader>/"] = { "gcc", h.setOpts({ desc = "which_key_ignore", remap = true }) },
	--
	-- move "line" at a time even on wrapped text
	["j"] = { "gj", h.setOpts() },
	["k"] = { "gk", h.setOpts() },
	--
	-- clear search highlights
	["<Esc>"] = { "<cmd>noh<cr>", h.setOpts({ desc = "ignore" }) },
	["jn"] = { "<cmd>noh<cr>", h.setOpts({ desc = "ignore" }) },
	--
	-- write buffer
	["<leader>w"] = { "<cmd>w<cr>", h.setOpts({ desc = "ignore" }) },
	--
	-- write all bufs
	["<leader>W"] = { "<cmd>wa<cr>", h.setOpts({ desc = "ignore" }) },
	--
	-- alternative close window closer to normal leader region than regular q
	["<leader>vc"] = {
		"<cmd>lua vim.cmd('wincmd q')<cr>",
		h.setOpts({ desc = "Quit a window" }),
	},
	--
	-- neovim help picker
	["<leader>?"] = { "<cmd>lua Snacks.picker.help()<cr>", h.setOpts({ desc = "󰋗 Help" }) },
	--
	-- my index fixing command
	["gz"] = { "<cmd>MultiplyLineWithIndexing<cr>", h.setOpts({ desc = "Multiply Line with Indexing" }) },
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
		h.setOpts({ desc = "󰏇 Toggle Oil" }),
	},
	--
	-- jump between bufs back and forth
	-- use barbar with native nvim fallback
	["<S-l>"] = {
		h.nextBufWithFallback,
		h.setOpts({ desc = "which_key_ignore", expr = true }),
	},
	["<S-h>"] = {
		h.prevBufWithFallback,
		h.setOpts({ desc = "which_key_ignore", expr = true }),
	},
	--
	-- AI
	["<leader>S"] = { "<cmd>ToggleAi<cr>", h.setOpts({ desc = " Toggle Supermaven" }) },
	--
	-- zen from Snacks
	["<leader>z"] = { "<cmd>lua Snacks.zen()<cr>", h.setOpts({ desc = " Toggle Zen Mode" }) },

	--
	-- whichkey neovim section
	["<leader>n"] = { " NeoVim" },
	["<leader>ns"] = { "<cmd>ClearSwap<cr>", h.setOpts({ desc = "Clear the Swap" }) },
	["<leader>nl"] = { "<cmd>Lazy<cr>", h.setOpts({ desc = "Open Lazy" }) },
	["<leader>nm"] = { "<cmd>Mason<cr>", h.setOpts({ desc = "Open Mason" }) },
	["<leader>nc"] = { "<cmd>checkhealth<cr>", h.setOpts({ desc = "Do Checkhealth" }) },
	["<leader>nh"] = { h.betterSnacksHlPicker, h.setOpts({ desc = "Look up HL Groups" }) },
	["<leader>nk"] = { "<cmd>lua Snacks.picker.keymaps()<cr>", h.setOpts({ desc = "Look up Key Mappings" }) },
	["<leader>nd"] = { "<cmd>lua require('notify').dismiss()<cr>", h.setOpts({ desc = "Dismiss Notifications" }) },
	--
	-- whichkey moveto section
	["<leader>m"] = { " Move To" },
	["<leader>mb"] = { "<cmd>lua Snacks.picker.buffers()<cr>", h.setOpts({ desc = "Find Buffers" }) },
	-- # Goto buffer in position...
	["<leader>m1"] = { "<Cmd>BufferGoto 1<cr>", h.setOpts({ desc = "Move to Buffer Index 1" }) },
	["<leader>m2"] = { "<Cmd>BufferGoto 2<cr>", h.setOpts({ desc = "Move to Buffer Index 2" }) },
	["<leader>m3"] = { "<Cmd>BufferGoto 3<cr>", h.setOpts({ desc = "Move to Buffer Index 3" }) },
	["<leader>m4"] = { "<Cmd>BufferGoto 4<cr>", h.setOpts({ desc = "Move to Buffer Index 4" }) },
	["<leader>m5"] = { "<Cmd>BufferGoto 5<cr>", h.setOpts({ desc = "Move to Buffer Index 5" }) },
	["<leader>m6"] = { "<Cmd>BufferGoto 6<cr>", h.setOpts({ desc = "Move to Buffer Index 6" }) },
	["<leader>m7"] = { "<Cmd>BufferGoto 7<cr>", h.setOpts({ desc = "Move to Buffer Index 7" }) },
	["<leader>m8"] = { "<Cmd>BufferGoto 8<cr>", h.setOpts({ desc = "Move to Buffer Index 8" }) },
	["<leader>m9"] = { "<Cmd>BufferGoto 9<cr>", h.setOpts({ desc = "Move to Buffer Index 9" }) },
	["<leader>m0"] = { "<Cmd>BufferLast<cr>", h.setOpts({ desc = "Move to Last Buffer" }) },
	--
	-- git stuff
	["<leader>g"] = { "󰊢 Git" },
	["<leader>gg"] = { "<cmd>lua Snacks.lazygit.open()<cr>", h.setOpts({ desc = "󰊢 LazyGit" }) },
	["<leader>gl"] = { "<cmd>lua Snacks.lazygit.log()<cr>", h.setOpts({ desc = "LazyGit Logs" }) },
	["<leader>gL"] = {
		"<cmd>lua Snacks.lazygit.log({args = { 'log', '-sm', 'full' }})<cr>",
		h.setOpts({ desc = "LazyGit Logs Graph" }),
	},
	["<leader>gs"] = { "<cmd>Gitsigns<cr>", h.setOpts({ desc = "Gitsigns Picker" }) },
	--
	-- general find stuff pickers from Snacks
	["<leader>f"] = { " Find" },
	["<leader>ff"] = { "<cmd>lua Snacks.picker.files()<cr>", h.setOpts({ desc = "Find Files" }) },
	["<leader>fw"] = {
		"<cmd>lua Snacks.picker.grep_word()<cr>",
		h.setOpts({ desc = "Find Word Under Cursor/Selection" }),
	},
	["<leader>fo"] = { "<cmd>lua Snacks.picker.grep_buffers()<cr>", h.setOpts({ desc = "Find in Opened Files" }) },
	["<leader>fb"] = { "<cmd>lua Snacks.picker.lines()<cr>", h.setOpts({ desc = "Current Buffer Lines" }) },
	["<leader>fd"] = { "<cmd>lua Snacks.picker.grep()<cr>", h.setOpts({ desc = "Find in CWD" }) },
	["<leader>fa"] = {
		"<cmd>lua Snacks.picker.files({hidden = true})<cr>",
		h.setOpts({ desc = "Find All Files (hidden etc.)" }),
	},
	["<leader>fp"] = { "<cmd>lua Snacks.picker.pickers()<cr>", h.setOpts({ desc = "Recent Pickers" }) },
	["<leader>fh"] = { "<cmd>lua Snacks.picker.command_history()<cr>", h.setOpts({ desc = "Command History" }) },
	["<leader>fu"] = { "<cmd>lua Snacks.picker.undo()<cr>", h.setOpts({ desc = "Find in Undo Tree" }) },
	["<leader>fc"] = { "<cmd>lua Snacks.picker.todo_comments()<cr>", h.setOpts({ desc = "Find Todo Comments" }) },
	["<leader>fv"] = {
		"<cmd>lua Snacks.picker.cliphist()<cr>",
		h.setOpts({ desc = "Find in OS Clipboard History." }),
	},
	--
	-- terminal
	["<C-t>"] = { "<cmd>lua  Snacks.terminal.toggle()<CR>", h.setOpts({ desc = "Toggle terminal" }) },
	--
	-- whichkey replace section for normal mode
	["<leader>r"] = { "󰛔 Replace" },
	["<leader>rw"] = { "Replace Cword" },
	["<leader>rr"] = { "Replace Init" },
	["<leader>rwi"] = { "<cmd>SearchReplaceCword true<cr>", h.setOpts({ desc = "Replace Cword Ignore Case" }) },
	["<leader>rwp"] = { "<cmd>SearchReplaceCword false<cr>", h.setOpts({ desc = "Replace Cword Preserve Case" }) },
	["<leader>rri"] = { "<cmd>SearchReplaceInit true<cr>", h.setOpts({ desc = "Replace Ignore Case" }) },
	["<leader>rrp"] = { "<cmd>SearchReplaceInit false<cr>", h.setOpts({ desc = "Replace Preserve Case" }) },
	--
	-- lsp section (configured in the lsp congfig)
	["<leader>l"] = { "  LSP" },
	--
	-- quickfix List with quicker
	["<leader>c"] = { " QuickFix List" },
	["<leader>cc"] = { "<cmd>lua require('quicker').toggle()<cr>", h.setOpts({ desc = "Toggle QuickFix List" }) },
	["<leader>cx"] = { h.clearQuickFixList, h.setOpts({ desc = "Force Clear QuickFix List" }) },
	--
	-- tmux navigator keymaps
	["<c-h>"] = { "<cmd>TmuxNavigateLeft<cr>", h.setOpts() },
	["<c-j>"] = { "<cmd>TmuxNavigateDown<cr>", h.setOpts() },
	["<c-k>"] = { "<cmd>TmuxNavigateUp<cr>", h.setOpts() },
	["<c-l>"] = { "<cmd>TmuxNavigateRight<cr>", h.setOpts() },
	--
	-- trouble lsp stuff and diagnostics
	["<leader>ll"] = {
		"<cmd>Trouble diagnostics toggle <cr>",
		h.setOpts({ desc = "Trouble LSP Diagnostics" }),
	},
	["<leader>lb"] = {
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		h.setOpts({ desc = "Trouble LSP Buffer Diagnostics" }),
	},
	["<leader>ld"] = { "<cmd>Trouble lsp_definitions<cr>", h.setOpts({ desc = "Trouble LSP Definitions" }) },
	["<leader>lD"] = { "<cmd>Trouble lsp_type_definitions<cr>", h.setOpts({ desc = "Trouble LSP Type Definitions" }) },
	["<leader>ls"] = { "<cmd>Trouble symbols toggle <cr>", h.setOpts({ desc = "Trouble Symbols" }) },
	["<leader>lS"] = { "<cmd>Trouble document_symbols toggle <cr>", h.setOpts({ desc = "Trouble Document Symbols" }) },
	["<leader>lr"] = {
		"<cmd>Trouble lsp_references toggle win.position=right<cr>",
		h.setOpts({ desc = "Trouble References" }),
	},
	["<leader>lI"] = {
		"<cmd>Trouble lsp_implementations win.position=right<cr>",
		h.setOpts({ desc = "Trouble Implementations" }),
	},
	["<leader>lq"] = { "<cmd>Trouble qflist toggle<cr>", h.setOpts({ desc = "Trouble Quickfix List" }) },
	--
	-- textcase case toggler for normal mode
	["<leader>~"] = { "󰬴 TextCase" },
	["<leader>~u"] = {
		"<cmd>lua require('textcase').current_word('to_upper_case')<CR>",
		h.setOpts({ desc = "Current Word to Upper Case" }),
	},
	["<leader>~l"] = {
		"<cmd>lua require('textcase').current_word('to_lower_case')<CR>",
		h.setOpts({ desc = "Current Word to Lower Case" }),
	},
	["<leader>~s"] = {
		"<cmd>lua require('textcase').current_word('to_snake_case')<CR>",
		h.setOpts({ desc = "Current Word to Snake Case" }),
	},
	["<leader>~d"] = {
		"<cmd>lua require('textcase').current_word('to_dash_case')<CR>",
		h.setOpts({ desc = "Current Word to Dash Case" }),
	},
	["<leader>~k"] = {
		"<cmd>lua require('textcase').current_word('to_dot_case')<CR>",
		h.setOpts({ desc = "Current Word to Dot Case" }),
	},
	["<leader>~f"] = {
		"<cmd>lua require('textcase').current_word('to_phrase_case')<CR>",
		h.setOpts({ desc = "Current Word to Phrase Case" }),
	},
	["<leader>~c"] = {
		"<cmd>lua require('textcase').current_word('to_camel_case')<CR>",
		h.setOpts({ desc = "Current Word to Camel Case" }),
	},
	["<leader>~p"] = {
		"<cmd>lua require('textcase').current_word('to_pascal_case')<CR>",
		h.setOpts({ desc = "Current Word to Pascal Case" }),
	},
	["<leader>~t"] = {
		"<cmd>lua require('textcase').current_word('to_title_case')<CR>",
		h.setOpts({ desc = "Current Word to Title Case" }),
	},
	["<leader>~w"] = {
		"<cmd>lua require('textcase').current_word('to_path_case')<CR>",
		h.setOpts({ desc = "Current Word to Path Case" }),
	},
	-- LSP Rename mappings
	["<leader>~U"] = {
		"<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Upper Case" }),
	},
	["<leader>~L"] = {
		"<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Lower Case" }),
	},
	["<leader>~S"] = {
		"<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Snake Case" }),
	},
	["<leader>~D"] = {
		"<cmd>lua require('textcase').lsp_rename('to_dash_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Dash Case" }),
	},
	["<leader>~K"] = {
		"<cmd>lua require('textcase').lspRename('to_dot_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Dot Case" }),
	},
	["<leader>~F"] = {
		"<cmd>lua require('textcase').lsp_rename('to_phrase_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Phrase Case" }),
	},
	["<leader>~C"] = {
		"<cmd>lua require('textcase').lspRename('to_camel_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Camel Case" }),
	},
	["<leader>~P"] = {
		"<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Pascal Case" }),
	},
	["<leader>~T"] = {
		"<cmd>lua require('textcase').lsp_rename('to_title_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Title Case" }),
	},
	["<leader>~W"] = {
		"<cmd>lua require('textcase').lspRename('to_path_case')<CR>",
		h.setOpts({ desc = "LSP Rename to Path Case" }),
	},
}

return M

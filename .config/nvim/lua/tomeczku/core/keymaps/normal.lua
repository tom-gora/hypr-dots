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
	-- fix polluting clipboard with non cutting operations with black hole register
	["ciw"] = { '"_ciw', h.setOpts({ desc = "ignore" }) },
	["caw"] = { '"_caw', h.setOpts({ desc = "ignore" }) },
	--
	-- yank all buf lines quickly
	["<leader>ya"] = { h.yankAll, h.setOpts({ desc = "ignore" }) },
	--
	-- delete all buf lines quickly
	["<leader>dd"] = { h.clearAll, h.setOpts({ desc = "ignore" }) },
	--
	-- yank from the cursor to the end of line
	["<S-Y>"] = { "y$", h.setOpts({ desc = "ignore" }) },
	--
	-- yank the line without newline char
	["<C-y>"] = { "mQ0y$`Q", h.setOpts({ desc = "ignore" }) },
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
	-- write all bufs vite
	["<leader>W"] = { "<cmd>wa<cr>", h.setOpts({ desc = "ignore" }) },
	--
	-- alternative close window closer to normal leader region than regular q
	["<leader>vc"] = {
		"<cmd>lua vim.cmd('wincmd q')<cr>",
		h.setOpts({ desc = "Quit a window" }),
	},
	--
	-- neovim help picker
	["<leader>?"] = { "<cmd>lua FzfLua.helptags()<cr>", h.setOpts({ desc = "󰋗 Help" }) },
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
	-- Zen Mode with system integration
	["<leader>z"] = { "<cmd>Focus<cr>", h.setOpts({ desc = " Toggle Zen Mode" }) },

	--
	-- whichkey neovim section
	["<leader>n"] = { " NeoVim" },
	["<leader>ns"] = { "<cmd>ClearSwap<cr>", h.setOpts({ desc = "Clear the Swap" }) },
	["<leader>nl"] = { "<cmd>Lazy<cr>", h.setOpts({ desc = "Open Lazy" }) },
	["<leader>nm"] = { "<cmd>Mason<cr>", h.setOpts({ desc = "Open Mason" }) },
	["<leader>nc"] = { "<cmd>checkhealth<cr>", h.setOpts({ desc = "Do Checkhealth" }) },
	["<leader>nh"] = { "<cmd>lua FzfLua.highlights()<cr>", h.setOpts({ desc = "Look up HL Groups" }) },
	["<leader>nk"] = { "<cmd>lua FzfLua.keymaps()<cr>", h.setOpts({ desc = "Look up Key Mappings" }) },
	["<leader>nd"] = { "<cmd>lua require('notify').dismiss()<cr>", h.setOpts({ desc = "Dismiss Notifications" }) },
	--
	-- whichkey move to section
	["<leader>b"] = { " Buffers" },
	["<leader>bb"] = { "<cmd>lua FzfLua.buffers()<cr>", h.setOpts({ desc = "Find Buffers" }) },
	["<leader>bc"] = { "<cmd>b#<cr>", h.setOpts({ desc = "Circle Previos Buffer" }) },
	["<leader>bl"] = { "<cmd>bnext<cr>", h.setOpts({ desc = "Next Buffer" }) },
	["<leader>bh"] = { "<cmd>bprevious<cr>", h.setOpts({ desc = "Previous Buffer" }) },

	--
	--
	-- git stuff
	["<leader>g"] = { "󰊢 Git" },
	["<leader>gg"] = {
		function()
			vim.fn.system("tmux run $TMUX_LAZYGIT_POPUP")
		end,
		h.setOpts({ desc = "LazyGit" }),
	},
	["<leader>gl"] = {
		function()
			vim.fn.system('tmux run "$TMUX_LAZYGIT_POPUP log"')
		end,
		h.setOpts({ desc = "LazyGit Logs" }),
	},
	["<leader>gL"] = {
		function()
			vim.fn.system('tmux run "$TMUX_LAZYGIT_POPUP log -sm full"')
		end,
		h.setOpts({ desc = "LazyGit Logs Graph" }),
	},
	["<leader>gf"] = { "<cmd>lua FzfLua.git_files()<cr>", h.setOpts({ desc = "Find Git Files" }) },
	["<leader>gs"] = { "<cmd>Gitsigns<cr>", h.setOpts({ desc = "Gitsigns Picker" }) },
	--
	-- general find stuff pickers
	["<M-m>"] = { "<cmd>lua FzfLua.resume()<cr>", h.setOpts({ desc = "ignore" }) },
	["<leader>f"] = { " Find" },
	["<leader>ff"] = { "<cmd>lua FzfLua.files({ hidden = false })<cr>", h.setOpts({ desc = "Find Files" }) },
	["<leader>fw"] = {
		"<cmd>lua FzfLua.grep_cword()<cr>",
		h.setOpts({ desc = "Find cword" }),
	},
	["<leader>fW"] = {
		"<cmd>lua FzfLua.grep_cWORD()<cr>",
		h.setOpts({ desc = "Find cWORD" }),
	},
	["<leader>fj"] = { "<cmd>lua FzfLua.jumps()<cr>", h.setOpts({ desc = "Find in Vim Jumps History" }) },
	["<leader>fl"] = { "<cmd>lua FzfLua.grep_last()<cr>", h.setOpts({ desc = "Resume Last Grep" }) },
	["<leader>fb"] = { "<cmd>lua FzfLua.grep_curbuf()<cr>", h.setOpts({ desc = "Find in Current Buffer" }) },
	["<leader>fd"] = { "<cmd>lua FzfLua.live_grep_native()<cr>", h.setOpts({ desc = "Find in Project" }) },
	["<leader>fa"] = {
		"<cmd>lua FzfLua.files({hidden = true})<cr>",
		h.setOpts({ desc = "Find All Files (hidden etc.)" }),
	},
	["<leader>fh"] = { "<cmd>lua FzfLua.command_history()<cr>", h.setOpts({ desc = "Command History" }) },
	-- NOTE: Missing (??) in fzf-lua: undo tree picker and todo-comments picker
	-- ["<leader>fu"] = { "?????", h.setOpts({ desc = "Find in Undo Tree" }) },
	-- ["<leader>ft"] = { "?????", h.setOpts({ desc = "Find Todo Comments" }) },
	--
	-- terminal
	["<C-t>"] = { h.toggleTmuxPopupTerm, h.setOpts({ desc = "Toggle terminal" }) },
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
	-- tmux navigator keyMap
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
	-- text-case: case toggling plugin for normal mode
	["<leader>~"] = { "󰬴 TextCase" },
	["<Leader>~u"] = {
		function()
			require("textcase").current_word("to_upper_case")
		end,
		h.setOpts({ desc = "Current Word to Upper Case" }),
	},
	["<leader>~l"] = {
		function()
			require("textcase").current_word("to_lower_case")
		end,
		h.setOpts({ desc = "Current Word to Lower Case" }),
	},
	["<leader>~s"] = {
		function()
			require("textcase").current_word("to_snake_case")
		end,
		h.setOpts({ desc = "Current Word to Snake Case" }),
	},
	["<leader>~d"] = {
		function()
			require("textcase").current_word("to_dot_case")
		end,
		h.setOpts({ desc = "Current Word to Dot Case" }),
	},
	["<leader>~k"] = {
		function()
			require("textcase").current_word("to_dash_case")
		end,
		h.setOpts({ desc = "Current Word to Kebab Case" }),
	},
	["<leader>~f"] = {
		function()
			require("textcase").current_word("to_phrase_case")
		end,
		h.setOpts({ desc = "Current Word to Phrase Case" }),
	},
	["<leader>~c"] = {
		function()
			require("textcase").current_word("to_camel_case")
		end,
		h.setOpts({ desc = "Current Word to Camel Case" }),
	},
	["<leader>~p"] = {
		function()
			require("textcase").current_word("to_pascal_case")
		end,
		h.setOpts({ desc = "Current Word to Pascal Case" }),
	},
	["<leader>~t"] = {
		function()
			require("textcase").current_word("to_title_case")
		end,
		h.setOpts({ desc = "Current Word to Title Case" }),
	},
	["<leader>~w"] = {
		function()
			require("textcase").current_word("to_path_case")
		end,
		h.setOpts({ desc = "Current Word to Path Case" }),
	},
	-- LSP Rename mappings
	["<leader>~U"] = {
		function()
			require("textcase").lsp_rename("to_upper_case")
		end,
		h.setOpts({ desc = "LSP Rename to Upper Case" }),
	},
	["<leader>~L"] = {
		function()
			require("textcase").lsp_rename("to_lower_case")
		end,
		h.setOpts({ desc = "LSP Rename to Lower Case" }),
	},
	["<leader>~S"] = {
		function()
			require("textcase").lsp_rename("to_snake_case")
		end,
		h.setOpts({ desc = "LSP Rename to Snake Case" }),
	},
	["<leader>~D"] = {
		function()
			require("textcase").lsp_rename("to_dash_case")
		end,
		h.setOpts({ desc = "LSP Rename to Dash Case" }),
	},
	["<leader>~K"] = {
		function()
			require("textcase").lspRename("to_dot_case")
		end,
		h.setOpts({ desc = "LSP Rename to Dot Case" }),
	},
	["<leader>~F"] = {
		function()
			require("textcase").lsp_rename("to_phrase_case")
		end,
		h.setOpts({ desc = "LSP Rename to Phrase Case" }),
	},
	["<leader>~C"] = {
		function()
			require("textcase").lspRename("to_camel_case")
		end,
		h.setOpts({ desc = "LSP Rename to Camel Case" }),
	},
	["<leader>~P"] = {
		function()
			require("textcase").lsp_rename("to_pascal_case")
		end,
		h.setOpts({ desc = "LSP Rename to Pascal Case" }),
	},
	["<leader>~T"] = {
		function()
			require("textcase").lsp_rename("to_title_case")
		end,
		h.setOpts({ desc = "LSP Rename to Title Case" }),
	},
	["<leader>~W"] = {
		function()
			require("textcase").lspRename("to_path_case")
		end,
		h.setOpts({ desc = "LSP Rename to Path Case" }),
	},
	--

	--
	-- blink completions
	["<leader>C"] = { h.toggleCopilot, h.setOpts({ desc = " Toggle Copilot" }) },
	-- spelling
	["<leader>s"] = { "󰓆 Spelling" },
	["<leader>st"] = {
		function()
			if not vim.wo.spell then
				vim.wo.spell = true
				return
			end
			vim.wo.spell = not vim.wo.spell
		end,
		{ desc = "Toggle Spell" },
	},
	["<leader>ss"] = {
		function()
			vim.cmd("norm! 1z=")
		end,
		h.setOpts({ desc = "Correct Word" }),
	},
	["<leader>sa"] = {
		function()
			vim.cmd("norm! zg")
		end,
		h.setOpts({ desc = "Add Word to Spellfile" }),
	},
	["<leader>sr"] = {
		function()
			vim.cmd("norm! zug")
		end,
		h.setOpts({ desc = "Remove Word from Spellfile" }),
	},
	["<leader>sb"] = {
		function()
			local word = vim.fn.expand("<cWORD>")
			vim.cmd("spellwrong! " .. word)
		end,
		h.setOpts({ desc = "Mark Word as Bad Spelling" }),
	},
	["<leader>sg"] = {
		function()
			local word = vim.fn.expand("<cWORD>")
			vim.cmd("spellgood! " .. word)
		end,
		h.setOpts({ desc = "Mark Word as Good Spelling" }),
	},
	["<leader>sm"] = {
		function()
			vim.cmd("mkspell! %")
		end,
		h.setOpts({ desc = "Compile Binary Spellfile" }),
	},
	-- boole. setup manually cuz plugin config fails me
	["<C-a>"] = { "<cmd>Boole increment<cr>", h.setOpts({ desc = "ignore" }) },
	["<C-x>"] = { "<cmd>Boole decrement<cr>", h.setOpts({ desc = "ignore" }) },

	-- repl terminals
	["<leader>t"] = { " REPL Terminals" },
}

return M

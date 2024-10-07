local map = vim.keymap.set
local ignore = { desc = "which_key_ignore" }
-- NOTE: ADDITIONAL ISOLATED FIXES
-- cannot be put in a tables to map by iteration
--
--fix polluting clipboard on pasting over visual selection
map("x", "p", "P", ignore)
-- dedicated remap for command mode to use without arrow keys
-- and c-j c-k addition for navigating compe completions
-- src for the latter: https://www.reddit.com/r/neovim/comments/ofg7tu/use_cj_and_ck_in_nvimcompe_instead_of_cp_cn/
map("c", "<c-l>", "<right>", { noremap = false })
map("c", "<c-h>", "<left>", { noremap = false })
-- HACK: This worked! with arcane vimscript! XD Dunno why but I'll take it
vim.cmd([[
cmap <C-j> <C-n>
cmap <C-k> <C-p>
]])
-- whichkey adjustments
local wk = require("which-key")
wk.add({
	{ "<leader>v", proxy = "<c-w>", group = " Splits" },
	{
		mode = { "x" },
		{ "<leader>ri", group = "Replace Inside Visual Selection" },
		{ "<leader>~", group = "󰬴 TextCase" },
	},
})

-- maps in tables to iterate over

-- normal mode maps table
local nNore
-- visual mode maps table
local xNore
-- insert mode maps table
local iNore
-- normal && visual maps table
local nxNore

-- declare normal mode keymaps key:bindig -> value:command, value: opts table
nNore = {
	--  fix polluting clipboard with non cutting operations
	["ciw"] = { '"_ciw', ignore },
	["caw"] = { '"_caw', ignore },
	-- select all buf lines quickly
	["<leader>a"] = { "ggVG", ignore },
	--
	-- position the cursor after pasted in text
	["p"] = { "gp", ignore },
	-- explicityly call native lsp action on go to file seems to fix
	-- toggle oil pane
	["<leader>e"] = { "<Cmd>Oil --float<cr>", { desc = "󰏇 Toggle Oil" } },
	-- toggle comment line in normal mode
	["<leader>/"] = { "gcc", vim.tbl_deep_extend("force", ignore, { remap = true }) },
	-- clear search highlights
	["<Esc>"] = { "<cmd>noh<cr>", ignore },
	["<leader>jk"] = { "<cmd>noh<cr>", ignore },
	-- write buffer
	["<leader>w"] = { "<cmd>w<cr>", ignore },
	-- write all bufs
	["<leader>W"] = { "<cmd>wa<cr>", ignore },
	-- jump between bufs back and forth
	-- barbar with native nvim fallback
	["<S-l>"] = {
		function()
			return pcall(require, "barbar") and "<cmd>BufferNext<cr>" or "<cmd>bnext<cr>"
		end,
		vim.tbl_deep_extend("force", ignore, { expr = true }),
	},
	["<S-h>"] = {
		function()
			return pcall(require, "barbar") and "<cmd>BufferPrevious<cr>" or "<cmd>bnext<cr>"
		end,
		vim.tbl_deep_extend("force", ignore, { expr = true }),
	},
	--
	-- AI toggler
	["<leader>S"] = { "<cmd>ToggleSupermaven<cr>", { desc = " Toggle Supermaven" } },
	--
	-- neovim help
	["<leader>?"] = { "<cmd>Telescope help_tags <cr>", { desc = "󰋗 Help" } },

	-- whichkey neovim section
	["<leader>n"] = { " NeoVim" },
	["<leader>ns"] = { "<cmd>ClearSwap<cr>", { desc = "Clear the Swap" } },
	["<leader>nl"] = { "<cmd>Lazy<cr>", { desc = "Open Lazy" } },
	["<leader>nm"] = { "<cmd>Mason<cr>", { desc = "Open Mason" } },
	["<leader>nc"] = { "<cmd>checkhealth<cr>", { desc = "Do Checkhealth" } },
	["<leader>nh"] = { "<cmd>Telescope highlights <cr>", { desc = "Look up HL Groups" } },
	["<leader>nd"] = { "<cmd>lua require('notify').dismiss()<cr>", { desc = "Dismiss Notifications" } },
	--
	-- whichkey goto section
	["<leader>g"] = { " Go To" },
	["<leader>gb"] = { "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" } },
	["<leader>gp"] = { "<cmd>BufferPick<cr>", { desc = "Pick Buffer from Tabline" } },
	-- Goto buffer in position...
	["<leader>g1"] = { "<Cmd>BufferGoto 1<cr>", { desc = "Go to Buffer Index 1" } },
	["<leader>g2"] = { "<Cmd>BufferGoto 2<cr>", { desc = "Go to Buffer Index 2" } },
	["<leader>g3"] = { "<Cmd>BufferGoto 3<cr>", { desc = "Go to Buffer Index 3" } },
	["<leader>g4"] = { "<Cmd>BufferGoto 4<cr>", { desc = "Go to Buffer Index 4" } },
	["<leader>g5"] = { "<Cmd>BufferGoto 5<cr>", { desc = "Go to Buffer Index 5" } },
	["<leader>g6"] = { "<Cmd>BufferGoto 6<cr>", { desc = "Go to Buffer Index 6" } },
	["<leader>g7"] = { "<Cmd>BufferGoto 7<cr>", { desc = "Go to Buffer Index 7" } },
	["<leader>g8"] = { "<Cmd>BufferGoto 8<cr>", { desc = "Go to Buffer Index 8" } },
	["<leader>g9"] = { "<Cmd>BufferGoto 9<cr>", { desc = "Go to Buffer Index 9" } },
	["<leader>g0"] = { "<Cmd>BufferLast<cr>", { desc = "Go to Last Buffer" } },
	--
	-- lazygit
	["<leader>G"] = { "<cmd>LazyGit<cr>", { desc = "󰊢 LazyGit" } },
	--
	-- whichkey find and telescope section
	["<leader>f"] = { " Find" },
	["<leader>ff"] = { "<cmd>Telescope find_files<cr>", { desc = "Find Files" } },
	["<leader>fw"] = { "<cmd>Telescope grep_string<cr>", { desc = "Find Word Under Cursor/Selection" } },
	-- Goto buffer in position...
	["<leader>fo"] = {
		"<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<cr>",
		{ desc = "Find in Opened Files" },
	},
	["<leader>fb"] = { "<Cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in Current Buffer" } },
	["<leader>fd"] = { "<Cmd>Telescope live_grep<cr>", { desc = "Find in CWD" } },
	["<leader>fa"] = {
		"<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
		{ desc = "Find All Files (hidden etc.)" },
	},
	["<leader>fp"] = { "<Cmd>Telescope pickers<cr>", { desc = "Recent Pickers" } },
	["<leader>fh"] = { "<Cmd>Telescope command_history<cr>", { desc = "Command History" } },
	["<leader>fu"] = { "<Cmd>Telescope undo<cr>", { desc = "Find in Undo Tree" } },
	["<leader>fs"] = { "<Cmd>Telescope symbols<cr>", { desc = "Find Symbols" } },
	["<leader>fe"] = { "<Cmd>Telescope file_browser<cr>", { desc = "Find in File Explorer" } },
	["<leader>fc"] = { "<Cmd>TodoTelescope<cr>", { desc = "Find Todo Comments" } },
	--
	-- whichkey terminal section
	["<leader>t"] = { " Terminal" },
	["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating TERM" } },
	["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal TERM" } },
	["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical TERM" } },
	--
	-- navigate splits
	["<C-h>"] = { "<C-w>h", ignore },
	["<C-l>"] = { "<C-w>l", ignore },
	["<C-j>"] = { "<C-w>j", ignore },
	["<C-k>"] = { "<C-w>k", ignore },

	-- whichkey replace section
	["<leader>r"] = { "󰛔 Replace" },
	["<leader>rw"] = { "Replace Cword" },
	["<leader>rr"] = { "Replace Init" },
	["<leader>rwi"] = { "<cmd>SearchReplaceCword true<cr>", { desc = "Replace Cword Ignore Case" } },
	["<leader>rwp"] = { "<cmd>SearchReplaceCword false<cr>", { desc = "Replace Cword Preserve Case" } },
	["<leader>rri"] = { "<cmd>SearchReplaceInit true<cr>", { desc = "Replace Ignore Case" } },
	["<leader>rrp"] = { "<cmd>SearchReplaceInit false<cr>", { desc = "Replace Preserve Case" } },
	--
	-- name the mappings for text-case plugin to keep the consistent whichkey look
	["<leader>~"] = { "󰬴 TextCase" },
	-- lspsaga section
	["<leader>l"] = { "  LSP" },
	["<leader>li"] = { "<cmd>LspInfo<cr>", { desc = "Lsp Info" } },
	["<leader>lD"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Show Line Diagnostics" } },
	["<leader>ld"] = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", { desc = "Show Diagnostics" } },
	["<leader>lb"] = { "<cmd>Lspsaga show_buf_diagnostics<cr>", { desc = "Show Diagnostics" } },
	["<leader>ll"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic" } },
	["<leader>lh"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Previous Diagnostic" } },
	["<leader>lk"] = { "<cmd>Lspsaga hover_doc<cr>", { desc = "Show Hover" } },
	["<leader>lw"] = { "<cmd>Lspsaga winbar_toggle<cr>", { desc = "Toggle Breadcrumbs" } },
	["<leader>lp"] = { "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek Definition" } },
	["<leader>lP"] = { "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Peek Type Definition" } },
	["<leader>lg"] = { "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto Definition" } },
	["<leader>lG"] = { "<cmd>Lspsaga goto_type_definition<cr>", { desc = "Goto Type Definition" } },
	["<leader>lr"] = { "<cmd>Lspsaga rename<cr>", { desc = "Lsp Rename" } },
	["<leader>lo"] = { "<cmd>Lspsaga outline<cr>", { desc = "Show Outline" } },
	["<leader>lf"] = { "<cmd>Lspsaga finder<cr>", { desc = "Show Symbol Finder" } },
	["<leader>lL"] = { "<cmd>Lspsaga open_log<cr>", { desc = "Open LspSaga Log" } },
	["<leader>lc"] = { "<cmd>Lspsaga code_action<cr>", { desc = "Lsp Code Action" } },
	-- my index fixing command
	["gz"] = { "<cmd>MultiplyLineWithIndexing<cr>", { desc = "Multiply Line with Indexing" } },
}

-- declare insert mode keymaps key:bindig -> value:command, value: opts table
iNore = {
	--
	--
	-- navigate within insert mode
	["<C-h>"] = { "<Left>", ignore },
	["<C-l>"] = { "<Right>", ignore },
	["<C-j>"] = { "<Down>", ignore },
	["<C-k>"] = { "<Up>", ignore },
}

-- declare visual mode keymaps key:bindig -> value:command, value: opts table
xNore = {
	--
	-- toggle comment line in visual mode
	["<leader>/"] = {
		"gc",
		vim.tbl_deep_extend("force", ignore, { remap = true }),
	},
	-- search and replace section
	["<leader>r"] = { " Replace" },
	["<leader>rs"] = { "<cmd>SearchReplaceVisualSelection<cr>", { desc = "Replace the Selection" } },
	["<leader>rii"] = { "<cmd>SearchReplaceInsideVisualSelection true<cr>", { desc = "Inside Selection Ignore Case" } },
	["<leader>rip"] = {
		"<cmd>SearchReplaceInsideVisualSelection false<cr>",
		{ desc = "Inside Selection Preserve Case" },
	},
	-- my index fixing command
	["gz"] = { ":<c-u>ApplyIndexingOverSelection<cr>", { desc = "Index Lines Inside Selection" } },
}

-- declare normal and visual mode keymaps key:bindig -> value:command, value: opts table
nxNore = {
	["c"] = { '"_c', ignore },
	["x"] = { '"_x', ignore },
	["d"] = { '"_d', ignore },
	--
	-- quick visual line select
	["<leader><leader>"] = { "V", ignore },
	--
	-- whichkey open section
	["<leader>o"] = { " Open" },
	["<leader>on"] = { "<cmd> enew <cr>", { desc = "Open New Buffer" } },
	["<leader>of"] = {
		function()
			local rootPath = vim.fn.expand("%:p:h")
			return ":e " .. rootPath .. "/"
		end,
		{ desc = "Open...", expr = true },
	},
	["<leader>oc"] = { "<cmd> e#<cr>", { desc = "Reopen Last Closed" } },
	["<leader>or"] = { "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent" } },
	["<leader>oo"] = { "<Cmd>Telescope file_browser<cr>", { desc = "Open With Telescope" } },
	["<leader>oq"] = { "<Cmd>copen<cr>", { desc = "Open Quickfix List" } },
	--
	-- whichkey close section
	["<leader>q"] = { " Close" },
	["<leader>qq"] = {
		function()
			return pcall(require, "barbar") and "<cmd>BufferClose<cr>" or "<cmd>bd<cr>"
		end,
		{ expr = true, desc = "Close Current Buffer" },
	},
	["<leader>qw"] = { "<cmd>qa!<cr>", { desc = "Force Close Neovim" } },
	["<leader>qa"] = { "<cmd>%bd!<cr>", { desc = "Close All Buffers" } },
	["<leader>qo"] = { "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Close All Other Buffers" } },
	["<leader>qu"] = { "<cmd>CloseUnmodifiedBuffers<cr>", { desc = "Close All Unmodified Buffers" } },
}

-- loop over nNore bindings and set the keymaps
for k, v in pairs(nNore) do
	map("n", k, v[1], v[2])
end

-- loop over iNore bindings and set the keymaps
for k, v in pairs(iNore) do
	map("i", k, v[1], v[2])
end

-- loop over xNore bindings and set the keymaps
for k, v in pairs(xNore) do
	map("x", k, v[1], v[2])
end

-- loop over nxNore bindings and set the keymaps
for k, v in pairs(nxNore) do
	map({ "n", "x" }, k, v[1], v[2])
end

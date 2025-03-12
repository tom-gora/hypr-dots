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
	["<leader>e"] = {
		function()
			local o = require("oil")
			-- if oil already opened and not focused then navigate to it
			if _G._OilOpened and vim.bo.filetype ~= "oil" then
				vim.fn.win_gotoid(_G._OilOpened)
				return
			elseif _G._OilOpened and vim.bo.filetype == "oil" then
				o.close()
				vim.api.nvim_win_close(_G._OilOpened, true)
				return
			end
			-- else open it in dynamically adjusted vsplit and set global storage for winid of oil
			-- local u = require("oil.util")
			vim.cmd("vsplit")
			vim.api.nvim_win_set_width(0, math.max(math.ceil(vim.api.nvim_win_get_width(0) / 3), 45))

			o.open()
			-- u.run_after_load(0, function()
			-- 	o.open_preview({ horizontal = true })
			--
			-- end)
			_G._OilOpened = vim.fn.win_getid()
		end,
		{ desc = "󰏇 Toggle Oil" },
	},
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
	-- alternative close window closer to normal leader region than regular q
	["<leader>vc"] = { "<cmd>lua vim.cmd('wincmd q')<cr>", { desc = "Quit a window" } },
	--
	-- AI
	["<leader>C"] = { "<cmd>ToggleCopilot<cr>", { desc = " Toggle Copilot" } },
	--
	-- neovim help
	["<leader>?"] = { "<cmd>lua Snacks.picker.help()<cr>", { desc = "󰋗 Help" } },

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
	-- Goto buffer in position...
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
	-- lazygit
	["<leader>g"] = { "󰊢 Git" },
	["<leader>gg"] = { "<cmd>lua Snacks.lazygit.open()<cr>", { desc = "󰊢 LazyGit" } },
	["<leader>gl"] = { "<cmd>lua Snacks.lazygit.log()<cr>", { desc = "LazyGit Logs" } },
	["<leader>gL"] = {
		"<cmd>lua Snacks.lazygit.log({args = { 'log', '-sm', 'full' }})<cr>",
		{ desc = "LazyGit Logs Graph" },
	},
	["<leader>gs"] = { "<cmd>Gitsigns<cr>", { desc = "Gitsigns Picker" } },
	--
	-- pickers
	["<leader>f"] = { " Find" },
	["<leader>ff"] = { "<cmd>lua Snacks.picker.files()<cr>", { desc = "Find Files" } },
	["<leader>fw"] = { "<cmd>lua Snacks.picker.grep_word()<cr>", { desc = "Find Word Under Cursor/Selection" } },
	-- Goto buffer in position...
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
	-- whichkey terminal section
	["<C-t>"] = { "<cmd>lua  Snacks.terminal.toggle()<CR>", { desc = "Toggle terminal" } },
	-- ["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal TERM" } },
	-- ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical TERM" } },
	--
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
	-- lsp section (configured in the lsp congfig)
	["<leader>l"] = { "  LSP" },
	--
	-- my index fixing command
	["gz"] = { "<cmd>MultiplyLineWithIndexing<cr>", { desc = "Multiply Line with Indexing" } },
	--
	-- quickfix List
	["<leader>c"] = { " QuickFix List" },
	["<leader>cc"] = { "<cmd>lua require('quicker').toggle()<cr>", { desc = "Toggle QuickFix List" } },
	["<leader>cx"] = {
		function()
			vim.cmd("cexpr []")
			vim.cmd("cclose")
		end,
		{ desc = "Force Clear QuickFix List" },
	},
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
	--
	-- silicon-nvim
	["<leader>s"] = { " Silicon" },
	["<leader>sc"] = {
		function()
			require("nvim-silicon").clip()
		end,
		{ desc = " -> To Clipboard" },
	},
	["<leader>sf"] = {
		function()
			require("nvim-silicon").file()
		end,
		{ desc = " -> To File" },
	},
	["<leader>ss"] = {
		function()
			require("nvim-silicon").shoot()
		end,
		{ desc = "  -> To Both" },
	},
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
	["<leader>or"] = { "<cmd>lua Snacks.picker.recent()<cr>", { desc = "Open Recent" } },
	--
	-- whichkey close section
	["<leader>q"] = { " Close" },
	["<leader>qq"] = {
		function()
			return pcall(require, "barbar") and "<cmd>BufferClose<cr>" or "<cmd>bd<cr>"
		end,
		{ expr = true, desc = "Close Current Buffer" },
	},
	["<leader>qw"] = { "<cmd>wqa!<cr>", { desc = "Force Close with Save" } },
	["<leader>QQ"] = { "<cmd>qa!<cr>", ignore },
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

map("t", "<C-t>", "<cmd>lua  Snacks.terminal.toggle()<CR>", { desc = "Toggle terminal" })

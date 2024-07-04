local map = vim.keymap.set
local ignore = { desc = "which_key_ignore" }

-- normal mode maps table
local n_nonrecursive = {}
-- visual mode maps table
local v_nonrecursive = {}
-- insert mode maps table
local i_nonrecursive = {}
-- normal && visual maps table
local nv_nonrecursive = {}

-- declare normal mode keymaps key:bindig -> value:command, value: opts table
n_nonrecursive = {
	["<leader>e"] = { "<Cmd>Oil --float<CR>", { desc = "󰏇 Toggle Oil"} },
	-- toggle comment line in normal mode
	["<leader>/"] = { "gcc", vim.tbl_deep_extend("force", ignore, { remap = true }) },
	-- clear search highlights
	["<Esc>"] = { "<cmd> noh <CR>", ignore },
	-- write buffer
	["<leader>w"] = { "<cmd>w<cr>", ignore },
  -- write all bufs
	["<leader>W"] = { "<cmd>wa<cr>", ignore },
  -- leader driven alias for c-w
	["<leader>v"] = { "<cmd>lua vim.api.nvim_input('<c-w>')<cr>", { desc = " Splits" } },


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
	-- whichkey neovim section
	["<leader>n"] = { " NeoVim" },
	["<leader>ns"] = {
		"<cmd>lua _G.ClearSwap()<CR>",
		{ desc = "Clear the Swap" },
	},
	["<leader>nl"] = {
		"<cmd>Lazy<CR>",
		{ desc = "Open Lazy" },
	},
	["<leader>nm"] = {
		"<cmd>Mason<CR>",
		{ desc = "Open Mason" },
	},

	["<leader>nc"] = {
		"<cmd>checkhealth<CR>",
		{ desc = "Do Checkhealth" },
	},
	["<leader>nh"] = {
		"<cmd> Telescope highlights <CR>",
		{ desc = "Look up Highlight groups" },
	},
	--
	-- whichkey goto section
	["<leader>g"] = { " Go To" },
	["<leader>gb"] = { "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" } },
	["<leader>gp"] = { "<cmd>BufferPick<cr>", { desc = "Pick Buffer from Tabline" } },
	-- Goto buffer in position...
	["<leader>g1"] = { "<Cmd>BufferGoto 1<CR>", { desc = "Go to Buffer Index 1" } },
	["<leader>g2"] = { "<Cmd>BufferGoto 2<CR>", { desc = "Go to Buffer Index 2" } },
	["<leader>g3"] = { "<Cmd>BufferGoto 3<CR>", { desc = "Go to Buffer Index 3" } },
	["<leader>g4"] = { "<Cmd>BufferGoto 4<CR>", { desc = "Go to Buffer Index 4" } },
	["<leader>g5"] = { "<Cmd>BufferGoto 5<CR>", { desc = "Go to Buffer Index 5" } },
	["<leader>g6"] = { "<Cmd>BufferGoto 6<CR>", { desc = "Go to Buffer Index 6" } },
	["<leader>g7"] = { "<Cmd>BufferGoto 7<CR>", { desc = "Go to Buffer Index 7" } },
	["<leader>g8"] = { "<Cmd>BufferGoto 8<CR>", { desc = "Go to Buffer Index 8" } },
	["<leader>g9"] = { "<Cmd>BufferGoto 9<CR>", { desc = "Go to Buffer Index 9" } },
	["<leader>g0"] = { "<Cmd>BufferLast<CR>", { desc = "Go to Last Buffer" } },
}

-- declare insert mode keymaps key:bindig -> value:command, value: opts table
i_nonrecursive = {
	--
	-- exit back  to normal with jj
	["jj"] = { "<Esc>", ignore },
	--
	-- navigate within insert mode
	["<C-h>"] = { "<Left>", ignore },
	["<C-l>"] = { "<Right>", ignore },
	["<C-j>"] = { "<Down>", ignore },
	["<C-k>"] = { "<Up>", ignore },
}

-- declare visual mode keymaps key:bindig -> value:command, value: opts table
v_nonrecursive = {
	--
	-- toggle comment line in visual mode
	["<leader>/"] = {
		"gc",
		vim.tbl_deep_extend("force", ignore, { remap = true }),
	},
}

-- declare normal and visual mode keymaps key:bindig -> value:command, value: opts table
nv_nonrecursive = {
	--
	-- quick visual line select
	["<leader><leader>"] = { "V", ignore },
	--
	-- whichkey open section
	["<leader>o"] = { " Open" },
	["<leader>on"] = { "<cmd> enew <CR>", { desc = "Open New Buffer" } },
	["<leader>of"] = {
		function()
			local root_path = vim.fn.expand("%:p:h")
			return ":e " .. root_path .. "/"
		end,
		{ desc = "Open...", expr = true },
	},
	["<leader>oc"] = { "<cmd> e#<CR>", { desc = "Reopen Last Closed" } },
	["<leader>or"] = { "<cmd>Telescope oldfiles<CR>", { desc = "Open Recent" } },
	--
	-- whichkey close section
	["<leader>q"] = { " Close" },
	["<leader>qq"] = {
		function()
			return pcall(require, "barbar") and "<cmd>BufferClose<cr>" or "<cmd>bd<cr>"
		end,
		{ expr = true, desc = "Close Current Buffer" },
	},
	["<leader>qw"] = { "<cmd>q!<cr>", { desc = "Force Close Neovim" } },
	["<leader>qa"] = { "<cmd>%bd!<cr>", { desc = "Close All Buffers" } },
	["<leader>qo"] = { "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Close All Other Buffers" } },
	["<leader>qu"] = { "<cmd>lua _G.CloseUnmodifiedBuffers()<CR>", { desc = "Close All Unmodified Buffers" } },
}

-- loop over n_nonrecursive bindings and set the keymaps
for k, v in pairs(n_nonrecursive) do
	map("n", k, v[1], v[2])
end

-- loop over i_nonrecursive bindings and set the keymaps
for k, v in pairs(i_nonrecursive) do
	map("i", k, v[1], v[2])
end

-- loop over v_nonrecursive bindings and set the keymaps
for k, v in pairs(v_nonrecursive) do
	map("v", k, v[1], v[2])
end

-- loop over nv_nonrecursive bindings and set the keymaps
for k, v in pairs(nv_nonrecursive) do
	map({ "n", "v" }, k, v[1], v[2])
end

local M, h = {}, require("tomeczku.core.keymaps.helpers")

M = {
	-- fix polluting clipboard with non cutting operations with blackhole register
	["c"] = { '"_c', h.setOpts({ desc = "ignore" }) },
	["x"] = { '"_x', h.setOpts({ desc = "ignore" }) },
	["d"] = { '"_d', h.setOpts({ desc = "ignore" }) },
	["D"] = { '"_D', h.setOpts({ desc = "ignore" }) },
	--
	-- position the cursor after pasted text
	["p"] = { "gP", h.setOpts({ desc = "ignore" }) },
	--
	-- quick visual line select
	["<leader><leader>"] = { "V", h.setOpts({ desc = "ignore" }) },
	--
	-- whichkey open section
	["<leader>o"] = { " Open" },
	["<leader>on"] = { "<cmd> enew <cr>", h.setOpts({ desc = "Open New Buffer" }) },
	["<leader>of"] = {
		h.openFileFromCmdLine,
		{ desc = "Open...", expr = true },
	},
	["<leader>oc"] = { "<cmd> e#<cr>", h.setOpts({ desc = "Reopen Last Closed" }) },
	["<leader>or"] = { "<cmd>lua Snacks.picker.recent()<cr>", h.setOpts({ desc = "Open Recent" }) },
	--
	-- whichkey close section
	["<leader>q"] = { " Close" },
	["<leader>qq"] = {
		h.closeBufWithFallback,
		h.setOpts({ expr = true, desc = "Close Current Buffer" }),
	},
	["<leader>qw"] = { "<cmd>wqa!<cr>", h.setOpts({ desc = "Force Close with Save" }) },
	["<leader>QQ"] = { "<cmd>qa!<cr>", h.setOpts({ desc = "ignore" }) },
	["<leader>qa"] = { "<cmd>%bd!<cr>", h.setOpts({ desc = "Force Close All Buffers" }) },
	["<leader>qo"] = { "<cmd>BufferCloseAllButCurrent<cr>", h.setOpts({ desc = "Close All Other Buffers" }) },
	["<leader>qu"] = { "<cmd>CloseUnmodifiedBuffers<cr>", h.setOpts({ desc = "Close All Unmodified Buffers" }) },
}

return M

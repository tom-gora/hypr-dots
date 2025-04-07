local M, ignore, h = {}, { desc = "which_key_ignore" }, require("tomeczku.core.keymaps.helpers")

M = {
	-- fix polluting clipboard with non cutting operations with blackhole register
	["c"] = { '"_c', ignore },
	["x"] = { '"_x', ignore },
	["d"] = { '"_d', ignore },
	["D"] = { '"_D', ignore },
	--
	-- position the cursor after pasted text
	["p"] = { "gP", ignore },
	--
	-- quick visual line select
	["<leader><leader>"] = { "V", ignore },
	--
	-- whichkey open section
	["<leader>o"] = { " Open" },
	["<leader>on"] = { "<cmd> enew <cr>", { desc = "Open New Buffer" } },
	["<leader>of"] = {
		h.openFileFromCmdLine,
		{ desc = "Open...", expr = true },
	},
	["<leader>oc"] = { "<cmd> e#<cr>", { desc = "Reopen Last Closed" } },
	["<leader>or"] = { "<cmd>lua Snacks.picker.recent()<cr>", { desc = "Open Recent" } },
	--
	-- whichkey close section
	["<leader>q"] = { " Close" },
	["<leader>qq"] = {
		h.closeBufWithFallback,
		{ expr = true, desc = "Close Current Buffer" },
	},
	["<leader>qw"] = { "<cmd>wqa!<cr>", { desc = "Force Close with Save" } },
	["<leader>QQ"] = { "<cmd>qa!<cr>", ignore },
	["<leader>qa"] = { "<cmd>%bd!<cr>", { desc = "Force Close All Buffers" } },
	["<leader>qo"] = { "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Close All Other Buffers" } },
	["<leader>qu"] = { "<cmd>CloseUnmodifiedBuffers<cr>", { desc = "Close All Unmodified Buffers" } },
}

return M

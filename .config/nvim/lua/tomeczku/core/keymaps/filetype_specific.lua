local M, map, h = {}, vim.keymap.set, require("tomeczku.core.keymaps.helpers")

M.lua = function()
	map("n", "gf", "<cmd>lua vim.lsp.buf.definition()<cr>", h.setOpts({ desc = "which_key_ignore" }))
end

M.markdown = function()
	map("n", "gm", "<cmd>MarkdownPreviewToggle<cr>", h.setOpts({ desc = " Markdown Preview" }))
end

M.laravel = function()
	map("n", "<leader>L", "", { desc = "󰫐 Laravel" })
	map("n", "<leader>LA", "<cmd>Laravel artisan<cr>", h.setOpts({ desc = "Laravel Artisan" }))
	map("n", "<leader>LR", "<cmd>Laravel routes<cr>", h.setOpts({ desc = "Laravel Routes" }))
	map("n", "<leader>LM", "<cmd>Laravel related<cr>", h.setOpts({ desc = "Laravel Related" }))
end

M.help = function()
	map("n", "<leader>q", function()
		if vim.bo.filetype == "help" then
			vim.api.nvim_win_close(0, true)
		else
			return
		end
	end, h.setOpts({ desc = "ignore" }))
end

M.quickfix = function()
	map("n", "<leader>rq", "<nop>", h.setOpts({ desc = "QF Replace", buffer = 0 }))
	map(
		"n",
		"<leader>rq1",
		"<cmd>SearchReplaceInQfManual true false<cr>",
		h.setOpts({ desc = "Ignore Case Manual", buffer = 0 })
	)
	map(
		"n",
		"<leader>rq2",
		"<cmd>SearchReplaceInQfManual true true<CR>",
		h.setOpts({ desc = "Ignore Case Update", buffer = 0 })
	)
	map(
		"n",
		"<leader>rq3",
		"<cmd>SearchReplaceInQfManual false true<CR>",
		h.setOpts({ desc = "Preserve Case Manual", buffer = 0 })
	)
	map(
		"n",
		"<leader>rq4",
		"<cmd>SearchReplaceInQfManual false false<CR>",
		h.setOpts({ desc = "Preserve Case Update", buffer = 0 })
	)
end

return M

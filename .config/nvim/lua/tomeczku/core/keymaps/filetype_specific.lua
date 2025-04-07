local M, map = {}, vim.keymap.set

M.lua = function()
	map("n", "gf", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "which_key_ignore" })
end

M.markdown = function()
	map("n", "gm", "<cmd>MarkdownPreviewToggle<cr>", { desc = " Markdown Preview" })
	-- move "line" at a time even on wrapped text
	map("n", "j", "gj", { noremap = true, silent = true })
	map("n", "k", "gk", { noremap = true, silent = true })
end

M.laravel = function()
	map("n", "<leader>L", "", { desc = "󰫐 Laravel" })
	map("n", "<leader>LA", "<cmd>Laravel artisan<cr>", { desc = "Laravel Artisan" })
	map("n", "<leader>LR", "<cmd>Laravel routes<cr>", { desc = "Laravel Routes" })
	map("n", "<leader>LM", "<cmd>Laravel related<cr>", { desc = "Laravel Related" })
end

M.help = function()
	map("n", "<leader>q", function()
		if vim.bo.filetype == "help" then
			vim.api.nvim_win_close(0, true)
		else
			return
		end
	end, { desc = "which_key_ignore" })
end

M.quickfix = function()
	map("n", "<leader>rq", "<nop>", { desc = "QF Replace", noremap = true, silent = true, buffer = 0 })
	map(
		"n",
		"<leader>rq1",
		"<cmd>SearchReplaceInQfManual true false<cr>",
		{ desc = "Ignore Case Manual", noremap = true, silent = true, buffer = 0 }
	)
	map(
		"n",
		"<leader>rq2",
		"<cmd>SearchReplaceInQfManual true true<CR>",
		{ desc = "Ignore Case Update", noremap = true, silent = true, buffer = 0 }
	)
	map(
		"n",
		"<leader>rq3",
		"<cmd>SearchReplaceInQfManual false true<CR>",
		{ desc = "Preserve Case Manual", noremap = true, silent = true, buffer = 0 }
	)
	map(
		"n",
		"<leader>rq4",
		"<cmd>SearchReplaceInQfManual false false<CR>",
		{ desc = "Preserve Case Update", noremap = true, silent = true, buffer = 0 }
	)
end

return M

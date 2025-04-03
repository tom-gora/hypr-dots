if vim.g.vscode then
	return
end

local M, init_function

init_function = function()
	vim.g.mkdp_page_title = "󰝗${name}󰉾 "
	vim.g.mkdp_open_ip = "127.0.0.1"
	vim.g.mkdp_port = "8765"
	vim.g.mkdp_echo_preview_url = 1
	vim.g.mkdp_auto_start = 0
	vim.g.mkdp_auto_close = 0
end

M = {
	{
		-- clone from my backup fork of fixed package that wasn't merged
		-- attribution for fix: Knyffen/markdown-preview.nvim
		-- "Knyffen/markdown-preview.nvim",
		"tom-gora/markdown-preview.nvim",
		cond = vim.g.vscode == nil,
		lazy = false,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm i",
		init = init_function,
		ft = { "markdown" },
	},
}

return M

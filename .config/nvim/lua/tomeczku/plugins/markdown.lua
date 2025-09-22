if vim.g.vscode then
	return
end

local M, preview_init_function

preview_init_function = function()
	vim.g.mkdp_page_title = "󰝗${name}󰉾 "
	vim.g.mkdp_open_ip = "127.0.0.1"
	vim.g.mkdp_port = "8765"
	vim.g.mkdp_echo_preview_url = 1
	vim.g.mkdp_auto_start = 0
	vim.g.mkdp_auto_close = 0
end

render_md_config_function = function()
	require("render-markdown").setup({
		completions = { blink = { enabled = true } },
	})
end

M = {
	{
		-- clone from my backup fork of fixed package that wasn't merged
		-- attribution for fixes: Knyffen/markdown-preview.nvim
		-- "Knyffen/markdown-preview.nvim",
		"tom-gora/markdown-preview.nvim",
		cond = vim.g.vscode == nil,
		lazy = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm i",
		init = preview_init_function,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		config = render_md_config_function,
		ft = { "markdown" },
	},
}

return M

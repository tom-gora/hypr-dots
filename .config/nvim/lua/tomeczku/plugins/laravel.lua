if vim.g.vscode then
	return
end

local M

M = {
	"adalessa/laravel.nvim",
	lazy = true,
	cond = vim.g.vscode == nil,
	ft = { "php", "blade" },
	cmd = { "Laravel" },
	dependencies = {
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"kevinhwang91/promise-async",
		"saghen/blink.cmp",
		{
			"ricardoramirezr/blade-nav.nvim",
			cond = vim.g.vscode == nil,
			optional = true,
			ft = { "blade", "php" },
			opts = {
				close_tag_on_complete = true,
			},
		},
	},
	config = true,
}

return M

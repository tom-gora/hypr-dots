local M = {}

M.dependencies = {
	"tpope/vim-dotenv",
	"MunifTanjim/nui.nvim",
	"kevinhwang91/promise-async",
}
-- only lazy load if in a blade or php file
M.ft = { "php", "blade" }
M.cmd = { "Laravel" }

M.bladenav = {
	"ricardoramirezr/blade-nav.nvim",
	optional = true,
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	ft = { "blade", "php" },
	opts = {
		close_tag_on_complete = true,
	},
}
return M

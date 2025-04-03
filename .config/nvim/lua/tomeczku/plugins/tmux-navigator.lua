if vim.g.vscode then
	return
end

local M, cmd_list, key_list

cmd_list = {
	"TmuxNavigateLeft",
	"TmuxNavigateDown",
	"TmuxNavigateUp",
	"TmuxNavigateRight",
	"TmuxNavigatePrevious",
	"TmuxNavigatorProcessList",
}

key_list = {
	{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
	{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
	{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
	{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
}

M = {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	cmd = cmd_list,
	keys = key_list,
}

return M

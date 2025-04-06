if vim.g.vscode then
	return
end

local M, cmd_list

cmd_list = {
	"TmuxNavigateLeft",
	"TmuxNavigateDown",
	"TmuxNavigateUp",
	"TmuxNavigateRight",
	"TmuxNavigatePrevious",
	"TmuxNavigatorProcessList",
}

M = {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	cmd = cmd_list,
}

return M

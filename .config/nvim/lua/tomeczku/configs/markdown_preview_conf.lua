local M = {}

M.init = function()
	vim.g.mkdp_page_title = "󰝗${name}󰉾 "
	vim.g.mkdp_open_ip = "127.0.0.1"
	vim.g.mkdp_port = "8888"
	vim.g.mkdp_echo_preview_url = 1
	vim.g.mkdp_auto_start = 1
	vim.g.mkdp_auto_close = 0
end

M.build_cmd = "cd app && npm i"

-- M.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }

return M

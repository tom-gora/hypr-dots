local M, handle_open, handle_close

handle_open = function(_win)
	-- environment
	-- fullscreen term in hyprland
	local fullscreen_state = vim.fn.system("hyprctl activewindow -j | jq '.fullscreenClient'")
	if not fullscreen_state or fullscreen_state == nil then
		return
	end
	local trimmed_fullscreen_state = string.match(fullscreen_state, "^%s*(.-)%s*$")
	if trimmed_fullscreen_state == "0" then
		vim.fn.system("hyprctl dispatch fullscreen")
	end
	local is_tmux = os.getenv("TMUX") ~= nil and #os.getenv("TMUX") > 0
	-- maximize tmux pane and hide statusline if in tmux
	if is_tmux then
		local is_pane_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'")
		local trimmed_is_pane_zoomed = string.match(is_pane_zoomed, "^%s*(.-)%s*$")
		vim.fn.system("tmux set status off")
		if trimmed_is_pane_zoomed == "0" then
			vim.fn.system("tmux resize-pane -Z")
		end
	end
	--
	-- window scope
	vim.wo[_win].signcolumn = "no"
	vim.wo[_win].foldcolumn = "0"
	vim.wo[_win].number = true
	vim.wo[_win].relativenumber = true
	vim.wo[_win].winhighlight = "SignColumn:Normal,FoldColumn:Normal"
	-- plugins
	is_snacks, snacks_indent = pcall(require, "snacks.indent")
	if is_snacks then
		snacks_indent.disable()
	end
	is_mini, mini_indent = pcall(require, "mini.indentscope")
	if is_mini then
		vim.b.miniindentscope_disable = true
	end
	--overrides
end

handle_close = function()
	-- environment
	-- exit fullscreen term in hyprland
	local fullscreen_state = vim.fn.system("hyprctl activewindow -j | jq '.fullscreenClient'")
	if not fullscreen_state or fullscreen_state == nil then
		return
	end
	local trimmed_fullscreen_state = string.match(fullscreen_state, "^%s*(.-)%s*$")
	if trimmed_fullscreen_state ~= "0" then
		vim.fn.system("hyprctl dispatch fullscreen")
	end
	-- minimize tmux pane and show statusline if in tmux
	local is_tmux = os.getenv("TMUX") ~= nil and #os.getenv("TMUX") > 0
	if is_tmux then
		local is_pane_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'")
		local trimmed_is_pane_zoomed = string.match(is_pane_zoomed, "^%s*(.-)%s*$")
		vim.fn.system("tmux set status on")

		if trimmed_is_pane_zoomed == "1" then
			vim.fn.system("tmux resize-pane -Z")
		end
	end
	-- plugins
	is_snacks, snacks_indent = pcall(require, "snacks.indent")
	if is_snacks then
		snacks_indent.disable()
	end
	is_mini, mini_indent = pcall(require, "mini.indentscope")
	if is_mini then
		vim.b.miniindentscope_disable = false
	end
end

M = {
	"cdmill/focus.nvim",
	cmd = { "Focus", "Zen", "Narrow" },
	config = function()
		require("focus").setup({
			window = {
				backdrop = false,
				width = 150,
				height = 1,
			},
			on_open = handle_open,
			on_close = handle_close,
		})
	end,
}

return M

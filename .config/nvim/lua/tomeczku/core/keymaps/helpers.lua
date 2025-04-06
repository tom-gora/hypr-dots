local M = {}

M.toggleOil = function()
	local ok, o = pcall(require, "oil")
	if not ok then
		vim.notify("Oil not available!", vim.log.levels.ERROR)
		return
	end
	-- if oil already opened and not focused then navigate to it
	if _G._OilOpened and vim.bo.filetype ~= "oil" then
		vim.fn.win_gotoid(_G._OilOpened)
		return
	elseif _G._OilOpened and vim.bo.filetype == "oil" then
		o.close()
		vim.api.nvim_win_close(_G._OilOpened, true)
		return
	end
	-- else open it in dynamically adjusted vsplit and set global storage for winid of oil
	-- local u = require("oil.util")
	vim.cmd("vsplit")
	vim.api.nvim_win_set_width(0, math.max(math.ceil(vim.api.nvim_win_get_width(0) / 3), 45))

	o.open()
	_G._OilOpened = vim.fn.win_getid()
end

M.nextBufWithFallback = function()
	return pcall(require, "barbar") and "<cmd>BufferNext<cr>" or "<cmd>bnext<cr>"
end

M.prevBufWithFallback = function()
	return pcall(require, "barbar") and "<cmd>BufferPrevious<cr>" or "<cmd>bprevious<cr>"
end

M.closeBufWithFallback = function()
	return pcall(require, "barbar") and "<cmd>BufferClose<cr>" or "<cmd>bd<cr>"
end

M.clearQuickFixList = function()
	vim.cmd("cexpr []")
	vim.cmd("cclose")
end

M.openTheVimWay = function()
	local rootPath = vim.fn.expand("%:p:h")
	return ":e " .. rootPath .. "/"
end

return M

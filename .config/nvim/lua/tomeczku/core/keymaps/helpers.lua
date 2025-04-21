local M = {}

M.operationNotifyHint = function(msg, title, icon)
	vim.notify(
		msg,
		vim.log.levels.INFO,
		{ title = title, icon = icon .. " ", timeout = 1500, hide_from_history = true }
	)
end

-- NOTE: setOpts() pass:
-- no args for default opts
-- desc = "ignore" for defaults but ignored by whichkey
-- any other valid mapping opts table to be merged with defaults
-- defaults are: { noremap = true, silent = true }

---@param extra vim.keymap.set.Opts? Nothing for defaults or table of additional mapping opts ( desc = "ignore" short for "which_key_ignore" )
---@return vim.keymap.set.Opts
M.setOpts = function(extra)
	local opts = { noremap = true, silent = true }
	if not extra or extra.desc == "" or extra == nil then
		return opts
	elseif extra.desc == "ignore" then
		return { noremap = true, silent = true, desc = "which_key_ignore" }
	end
	return vim.tbl_deep_extend("force", opts, extra)
end

M.yankFromCursorToEOL = function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("y$", true, false, true), "n", false)
end

M.yankAll = function()
	-- compared to ggVG preserves cursor position
	-- plus I grab the last message and redirect to notify
	vim.cmd("%y")
	local messages = vim.fn.execute("messages")
	local it = vim.iter(vim.split(messages, "\n"))
	M.operationNotifyHint("Whole buffer: " .. it:last(), "Yanked Buffer", "")
end

M.clearAll = function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("ggVGd", true, false, true), "n", false)
	M.operationNotifyHint("Cleared entire buffer", "Cleared Buffer", "")
end

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

---@return string
M.nextBufWithFallback = function()
	return pcall(require, "barbar") and "<cmd>BufferNext<cr>" or "<cmd>bnext<cr>"
end
---@return string
M.prevBufWithFallback = function()
	return pcall(require, "barbar") and "<cmd>BufferPrevious<cr>" or "<cmd>bprevious<cr>"
end

---@return string
M.closeBufWithFallback = function()
	return pcall(require, "barbar") and "<cmd>BufferClose<cr>" or "<cmd>bd<cr>"
end

M.clearQuickFixList = function()
	vim.cmd("cexpr []")
	vim.cmd("cclose")
end

---@return string
M.openFileFromCmdLine = function()
	local rootPath = vim.fn.expand("%:p:h")
	return ":e " .. rootPath .. "/"
end

---@param bufnr number
M.setupLspMappings = function(bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end
	nmap("<leader>lp", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
	nmap("<leader>ln", vim.diagnostic.goto_next, "Go to next diagnostic message")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")

	nmap("<leader>lc", vim.lsp.buf.code_action, "Code Actions")
	nmap("<leader>lR", vim.lsp.buf.rename, "Rename Symbol")

	nmap("<leader>lf", vim.lsp.buf.format, "Format Buffer")
	nmap("<leader>li", "<cmd>checkhealth vim.lsp<cr>", "Info")
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, { buffer = 0 })
end

return M

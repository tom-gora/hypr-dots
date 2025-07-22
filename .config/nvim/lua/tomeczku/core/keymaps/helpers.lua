local M = {}

---@param msg string: Message for notification to display
---@param title string: notification window title
---@param icon string: icon/symbol to display in notification
---@return void: Wrapper with predefined opts for longer lasting warn notification
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

---@return void
M.yankAll = function()
	-- compared to ggVGy preserves cursor position
	-- plus I grab the last message and redirect to notify
	vim.cmd("%y")
	local last_msg = vim.api.nvim_get_vvar("statusmsg")
	M.operationNotifyHint("Whole buffer: " .. last_msg, "Yanked Buffer", "")
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
	-- on startup oil opens default as only and main loaded buf - do not handle
	-- another early return
	if not _G._OilOpened and vim.bo.filetype == "oil" then
		return
	end
	-- if oil already opened and not focused then navigate to it
	if _G._OilOpened and vim.bo.filetype ~= "oil" then
		vim.fn.win_gotoid(_G._OilOpened)
		return
	-- if opened and focused close and clear tracking global var
	elseif _G._OilOpened and vim.bo.filetype == "oil" then
		local ok_close, _ = pcall(vim.api.nvim_win_close, _G._OilOpened, true)
		if ok_close then
			_G._OilOpened = nil
			return
		end
	end
	-- last case toggle on, adjust split
	vim.cmd("vs")
	vim.api.nvim_win_set_width(0, math.max(math.ceil(vim.api.nvim_win_get_width(0) / 33), 40))
	o.open(nil, nil, function()
		if vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_get_current_buf() }) == "oil" then
			_G._OilOpened = vim.fn.win_getid()
			-- set oil split to darker like pickers and floats
			vim.api.nvim_win_set_option(_G._OilOpened, "winhighlight", "Normal:NormalFloat")
			-- do not show eob fillchars in oil bufers
			vim.wo[_G._OilOpened].fillchars = string.gsub(vim.wo[_G._OilOpened].fillchars, "eob:[^,]*", "eob: ")
		else
			_G._OilOpened = nil
		end
	end)
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
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")

	nmap("<leader>lc", vim.lsp.buf.code_action, "Code Actions")
	nmap("<leader>lR", vim.lsp.buf.rename, "Rename Symbol")

	nmap("<leader>lf", vim.lsp.buf.format, "Format Buffer")
	nmap("<leader>li", "<cmd>checkhealth vim.lsp<cr>", "Info")
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, { buffer = 0 })
end

M.setDiagnosticsMappings = function()
	_G.diagnostics_showing = true
	vim.keymap.set("n", "<leader>lp", function()
		vim.diagnostic.jump({ count = -1, float = false })
	end, M.setOpts({ desc = "Go to previous diagnostic message" }))
	vim.keymap.set("n", "<leader>ln", function()
		vim.diagnostic.jump({ count = 1, float = false })
	end, M.setOpts({ desc = "Go to next diagnostic message" }))
	vim.keymap.set("n", "ll", function()
		local lnum = vim.fn.getcurpos()[2] - 1
		---@diagnostic disable-next-line: param-type-not-match
		local count = #vim.diagnostic.get(0, { lnum = lnum })
		if count and count > 0 then
			vim.diagnostic.open_float()
		else
			vim.cmd("normal! ll")
		end
	end, M.setOpts({ desc = "Open diagnostic float on a line" }))
	vim.keymap.set("n", "<leader>lt", function()
		if not _G.diagnostics_showing or _G.diagnostics_showing ~= true then
			vim.diagnostic.show()
			_G.diagnostics_showing = not _G.diagnostics_showing
		else
			vim.diagnostic.hide()
			_G.diagnostics_showing = not _G.diagnostics_showing
		end
	end, M.setOpts({ desc = "Toggle Inline Diagnostics" }))
end

---@param color number|string
---@return string
local decToHexColor = function(color)
	if type(color) ~= "string" or string.match(color, "^#") == nil then
		return string.format("#%06X", color)
	end
	return tostring(color)
end

M.toggleCopilot = function()
	if not _G.COPILOT_ENABLED or _G.COPILOT_ENABLED == false then
		vim.cmd("Copilot enable")
		_G.COPILOT_ENABLED = not _G.COPILOT_ENABLED
		return
	end
	vim.cmd("Copilot disable")
	_G.COPILOT_ENABLED = not _G.COPILOT_ENABLED
end

M.tmuxNavigateAwayFromTerminal = function()
	local win_conf = vim.api.nvim_win_get_config(vim.api.nvim_get_current_win())
	local buftype = vim.api.nvim_get_option_value("buftype", { buf = vim.api.nvim_get_current_buf() })
	if not buftype or buftype ~= "terminal" then
		return
	end

	if win_conf.split == "right" then
		vim.cmd([[stopinsert]])
		vim.cmd("TmuxNavigateLeft")
		return
	elseif win_conf.split == "below" then
		vim.cmd([[stopinsert]])
		vim.cmd("TmuxNavigateUp")
		return
	end
end

M.toggleTmuxPopupTerm = function()
	local is_tmux = os.getenv("TMUX") ~= nil and #os.getenv("TMUX") > 0
	if not is_tmux then
		vim.notify("Not running inside TMUX! Cannot execute TMUX popups.", vim.log.levels.ERROR)
		return
	end
	local zhs_popup_command = os.getenv("TMUX_ZSH_POPUP")
	if not zhs_popup_command or #zhs_popup_command <= 0 then
		zhs_popup_command = "\"\\#{@popup-toggle} -Ed'#{pane_current_path}' -w80% -h80% --name=zsh' zsh\""
	end
	-- single line
	zhs_popup_command = zhs_popup_command:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
	-- escapes
	local zhs_popup_command = string.format('"%s"', zhs_popup_command:gsub('"', '\\"'))

	vim.fn.system("tmux run " .. zhs_popup_command)
end

-- TODO: One day refactor this under-construction code meant to take numeric input AFTER keybind trigger
-- M.helixStylePostOperatorCount = function(max_digits)
-- 	local chars = ""
-- 	local countdown = vim.uv.new_timer()
--
-- 	countdown:start(
-- 		1000,
-- 		0,
-- 		vim.schedule_wrap(function()
-- 			vim.cmd("REPLExec $todo clear && todo -r " .. tonumber(chars))
-- 			-- HACK: Feed dummy esc to kill the loop
-- 			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
-- 			countdown:stop()
-- 			countdown:close()
-- 		end)
-- 	)
--
-- 	while #chars < max_digits do
-- 		local char_ok, char = pcall(vim.fn.getcharstr)
-- 		if char == "\27" then
-- 			return chars
-- 		end
-- 		if not char_ok or char == "" or tonumber(char) == nil then
-- 			return nil
-- 		end
-- 		chars = chars .. char
-- 		local count = tonumber(chars)
-- 		if count > total_tasks then
-- 			return "too_many"
-- 		end
-- 	end
-- 	return chars
-- end

return M

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

---@param hl_entry table
---@param title string
local notifyColors = function(hl_entry, title)
	-- hide existing notifications
	require("snacks.notifier").hide()
	local i = vim.log.levels.INFO
	vim.notify("", i, {
		title = title,
		keep = function(notif)
			local n_winnr = notif.win.win -- spawned notification window
			local width = vim.fn.winwidth(n_winnr) --get width
			-- predefined strings
			local r_str_fg = "  foreground   "
			local r_str_bg = "  background   "
			local r_str_sp = "  special   "
			local footer = "Yank colors. 'Esc' / 'q' to close."
			--
			--
			-- conditionally construct notification text based on what entries available
			if hl_entry.fg and not hl_entry.bg then
				local padding_len = math.ceil(width - (#tostring(hl_entry.fg) + 1 + #r_str_fg))
				notif.msg = {
					decToHexColor(hl_entry.fg) .. string.rep(" ", padding_len) .. r_str_fg,
					string.rep("─", width - 2),
					footer,
				}
			elseif hl_entry.bg and not hl_entry.fg then
				local padding_len = width - (#tostring(hl_entry.bg) + 1 + #r_str_bg)
				notif.msg = {
					decToHexColor(hl_entry.bg) .. string.rep(" ", padding_len) .. r_str_bg,
					string.rep("─", width - 2),
					footer,
				}
			---@diagnostic disable-next-line: unnecessary-if
			elseif hl_entry.bg and hl_entry.fg then
				local padding_len_fg = width - (#tostring(hl_entry.fg) + 1 + #r_str_fg)
				local padding_len_bg = width - (#tostring(hl_entry.bg) + 1 + #r_str_bg)
				notif.msg = {
					decToHexColor(hl_entry.fg) .. string.rep(" ", padding_len_fg) .. r_str_fg,
					decToHexColor(hl_entry.bg) .. string.rep(" ", padding_len_bg) .. r_str_bg,
					string.rep("─", width - 2),
					footer,
				}
			elseif hl_entry.sp then
				local padding_len = width - (#tostring(hl_entry.sp) + 1 + #r_str_sp)
				notif.msg = {
					decToHexColor(hl_entry.sp) .. string.rep(" ", padding_len) .. r_str_sp,
					string.rep("─", width - 2),
					footer,
				}
			else
				-- fail with notification
				vim.notify_once("Something went wrong extracting colors!", vim.log.levels.ERROR)
				return false
			end
			vim.api.nvim_set_current_win(n_winnr) -- focus in the notification win
			-- adding additional title because using "minimal" noti style
			-- if redundant remove title key
			vim.api.nvim_win_set_config(n_winnr, {
				border = "solid",
				title = " " .. title .. " ",
				relative = "editor",
				height = #notif.msg,
				col = vim.o.columns,
				row = vim.o.lines - (#notif.msg + 3),
			})

			local n_bufnr = vim.api.nvim_win_get_buf(n_winnr) -- notification's buffer
			-- dirty modify in place buffer content and window props. set cursor before first color string
			vim.keymap.set({ "n", "x" }, "<Esc>", function()
				require("snacks.notifier").hide()
			end, { silent = true, noremap = true, desc = "which_key_ignore", buffer = n_bufnr })
			vim.api.nvim_set_option_value("modifiable", true, { buf = n_bufnr })
			vim.api.nvim_put(notif.msg, "", false, true)
			vim.api.nvim_win_set_cursor(n_winnr, { 1, 0 })
			vim.api.nvim_set_option_value("modifiable", false, { buf = n_bufnr })
			return false
		end,
	})
end

---@param picker any
---@param item any
local hlConfirmCallback = function(picker, item)
	local hl_entry = nil
	local hl_group = nil
	-- get info from picker selection and parse as lua table
	local item_table = assert(load("return " .. item.text))()
	-- go over entries and extract colors either directly from item or tetrieving from linked group
	for _, item_entry in ipairs(item_table) do
		if item_entry.hl.fg or item_entry.hl.bg then
			hl_entry = item_entry.hl
			hl_group = item_entry.group
			break
		elseif item_entry.hl.link then
			local linked = vim.api.nvim_get_hl(0, { name = item_entry.hl.link })
			hl_entry = linked
			hl_group = item_entry.hl.link
			break
		end
	end
	-- fail with notification
	if hl_entry == nil or hl_group == nil then
		vim.notify_once("No colors table found for this highlight.", vim.log.levels.WARN)
		picker:close()
		return
	end
	-- call notification wrapper-formatter
	notifyColors(hl_entry, hl_group)
	picker:close()
end

-- wrapper calls picker with custom confirm
M.betterSnacksHlPicker = function()
	local snacks = require("snacks")
	snacks.picker.highlights({
		confirm = hlConfirmCallback,
		prompt = " ",
	})
end

M.toggleAiderModels = function()
	local at = require("nvim_aider.terminal")
	local models = _G.AIDER_MODELS
	if not _G.AIDER_WRITING or _G.AIDER_WRITING ~= true then
		at.command("/model " .. models.default_coding.model)
		at.command("/weak-model " .. models.default_coding.weak_model)
		-- vim.notify("Switched to writing models.", vim.log.levels.INFO)
		local txt = "Switched to writing models."
		local msg = txt:gsub('"', '\\"')
		os.execute('notify-send -u normal "Aider" "' .. msg .. '"')
	else
		at.command("/model " .. models.writing.model)
		at.command("/weak-model " .. models.writing.weak_model)
		-- vim.notify("Switched to coding models.", vim.log.levels.INFO)
		local txt = "Switched to coding models."
		local msg = txt:gsub('"', '\\"')
		os.execute('notify-send -u normal "Aider" "' .. msg .. '"')
	end
	_G.AIDER_WRITING = not _G.AIDER_WRITING
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
	local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_get_current_buf() })
	if not buf_ft or buf_ft ~= "snacks_terminal" then
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

return M

-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞
--
local M = {}
-- bring my utils in
local utils = require("tomeczku.core.custom_statusline.utils")
-- declare modes (declarations borrowed from nvchad)
local modes = {
	["n"] = { "NORMAL", "St_NormalMode" },
	["no"] = { "NORMAL (no)", "St_NormalMode" },
	["nov"] = { "NORMAL (nov)", "St_NormalMode" },
	["noV"] = { "NORMAL (noV)", "St_NormalMode" },
	["noCTRL-V"] = { "NORMAL", "St_NormalMode" },
	["niI"] = { "NORMAL i", "St_NormalMode" },
	["niR"] = { "NORMAL r", "St_NormalMode" },
	["niV"] = { "NORMAL v", "St_NormalMode" },
	["nt"] = { "NTERMINAL", "St_NTerminalMode", "T" },
	["ntT"] = { "NTERMINAL (ntT)", "St_NTerminalMode", "T" },

	["v"] = { "VISUAL", "St_VisualMode" },
	["vs"] = { "V-CHAR (Ctrl O)", "St_VisualMode" },
	["V"] = { "V-LINE", "St_VisualMode" },
	["Vs"] = { "V-LINE", "St_VisualMode" },
	[""] = { "V-BLOCK", "ST_VisualMode" },

	["i"] = { "INSERT", "St_InsertMode" },
	["ic"] = { "INSERT (completion)", "St_InsertMode" },
	["ix"] = { "INSERT completion", "St_InsertMode" },

	["t"] = { "TERMINAL", "St_TerminalMode" },

	["R"] = { "REPLACE", "St_ReplaceMode" },
	["Rc"] = { "REPLACE (Rc)", "St_ReplaceMode" },
	["Rx"] = { "REPLACEa (Rx)", "St_ReplaceMode" },
	["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
	["Rvc"] = { "V-REPLACE (Rvc)", "St_ReplaceMode" },
	["Rvx"] = { "V-REPLACE (Rvx)", "St_ReplaceMode" },

	["s"] = { "SELECT", "St_SelectMode" },
	["S"] = { "S-LINE", "St_SelectMode" },
	["␓"] = { "S-BLOCK", "St_SelectMode" },
	["c"] = { "COMMAND", "St_CommandMode" },
	["cv"] = { "COMMAND", "St_CommandMode" },
	["ce"] = { "COMMAND", "St_CommandMode" },
	["r"] = { "PROMPT", "St_ConfirmMode" },
	["rm"] = { "MORE", "St_ConfirmMode" },
	["r?"] = { "CONFIRM", "St_ConfirmMode" },
	["x"] = { "CONFIRM", "St_ConfirmMode" },
	["!"] = { "SHELL", "St_TerminalMode" },
}

-- integrated module combining mode indicator and file name/path
-- if path is longer than 40 chars it will get truncated in the style
-- of the fish shell
-- also on splits at least half the screen only file name will be displayed
-- next to the root directory

---@return string
M.mode_plus_path = function()
	if not utils.is_activewin() then
		return ""
	end
	-- tweak normal mode ( nvim logo is a fallback so no need to declare all)
	modes["n"][3] = "N"
	-- tweak visual modes
	modes["v"][3] = "V"
	modes["Vs"][3] = "VL"
	modes["V"][3] = "VL"
	modes[""][3] = "VB"
	-- tweak insert modes
	modes["i"][3] = "I"
	modes["ic"][3] = "I"
	modes["ix"][3] = "I"
	-- tweak terminal mode
	modes["t"][3] = '%{&ft == "toggleterm" ? "  [".b:toggle_number."]" : ""}'
	modes["nt"][3] = '%#St_NTerminalModeCustomTxt#%{&ft == "toggleterm" ? "  [".b:toggle_number."]" : ""}'
	local root_sep = ""
	local path_end_sep = ""
	local path_components = utils.path_formatter(root_sep, path_end_sep)
	local m = vim.api.nvim_get_mode().mode
	local component_string = "%#"
		.. modes[m][2]
		.. "#"
		.. " "
		.. "%#"
		.. modes[m][2]
		.. "CustomTxt"
		.. "#"
		.. (modes[m][3] or "")
		.. " "
		.. "%#"
		.. modes[m][2]
		.. "_Root_Sep#"
		.. path_components["root_sep"]
		.. "%#St_Root#"
		.. path_components["root"]
		.. "%#"
		.. modes[m][2]
		.. "Text#"
		.. " "
		.. path_components["path"]
		.. "%#St_sep_r#"
		.. path_components["path_end_sep"]
		.. "%#St_EmptySpace#  "
	return component_string
end

---@return string
M.git = function()
	if not utils.is_activewin() then
		return ""
	end

	if not vim.b[utils.stbufnr()].gitsigns_head or vim.b[utils.stbufnr()].gitsigns_git_status then
		return ""
	end

	local git_status = vim.b[utils.stbufnr()].gitsigns_status_dict

	local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
	local branch_name = " " .. git_status.head

	return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed
end

---@return string
M.macro_indicator = function()
	if not utils.is_activewin() then
		return ""
	end

	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "%#St_macro_sep#%#St_macro_reg# " .. recording_register .. "%#St_macro_sep#%#St_EmptySpace#  "
	end
	-- return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed
end

---@return string
M.lsp_diags = function()
	if not utils.is_activewin() or not rawget(vim, "lsp") then
		return ""
	end
	local s = vim.diagnostic.severity

	local errors = #vim.diagnostic.get(utils.stbufnr(), { severity = s.ERROR })
	local warnings = #vim.diagnostic.get(utils.stbufnr(), { severity = s.WARN })
	local hints = #vim.diagnostic.get(utils.stbufnr(), { severity = s.HINT })
	local info = #vim.diagnostic.get(utils.stbufnr(), { severity = s.INFO })

	local e = (errors and errors > 0) and ("%#St_lspError#" .. " " .. errors .. " ") or ""
	local w = (warnings and warnings > 0) and ("%#St_lspWarning#" .. "  " .. warnings .. " ") or ""
	local h = (hints and hints > 0) and ("%#St_lspHints#" .. " " .. hints .. " ") or ""
	local i = (info and info > 0) and ("%#St_lspInfo#" .. " " .. info .. " ") or ""

	return e .. w .. h .. i
end

---@return string
M.lsp_status = function()
	if not utils.is_activewin() then
		return ""
	end

	local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win() or 0)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if not clients or #clients == 0 then
		return ""
	end
	local lsp_string = utils.makeLspString(bufnr, clients)
	--
	if lsp_string and lsp_string ~= "" then
		return (
			vim.o.columns > 86
			and "%#St_ConfirmMode#"
				.. "%#St_ConfirmModeCustomTxt#"
				.. lsp_string.icon
				.. lsp_string.name
				.. "%#St_ConfirmMode# "
		) or "%#St_ConfirmMode# "
	end
	-- just draw nothing if no lsp client or err out with nil values for string
	return ""
end

---@return string
M.cursor_pos = function()
	if not utils.is_activewin() then
		return ""
	end

	-- if narrow window don't even bother
	if utils.is_narrow_split() then
		return ""
	end
	-- added padding function to make the module less "jumpy" in terms of width while navigating buffers
	-- now the only realistic "width jump" will appear when exceeding 99 lines position (or I guess 999)
	-- result is much less jarring
	local line_col = string.format("%2d/%-2d", vim.fn.line("."), vim.fn.col("."))
	return "%#St_Pos_sep#"
		.. ""
		.. "%#St_Pos_bg#"
		.. ""
		.. "%#St_Pos_bg# "
		.. line_col
		.. "%#St_Pos_sep#"
		.. ""
end

---@return string
M.ai_status = function()
	if vim.g.SUPERMAVEN_DISABLED == 1 then
		return "%#NonText#   "
	end
	return "%#String#   "
end

--- @return string
M.markdown_wordcounter = function()
	if vim.b.markdown ~= true then
		return ""
	end
	require("tomeczku.core.custom_statusline.markdown_wc.markdown_wc").setup()

	-- read stored count set on a buf table
	local count = vim.b.markdown_word_count
	local result_text

	if count == nil then
		result_text = " ERR "
	elseif count == -1 then
		-- "loading state"
		result_text = " Counting ..."
	else
		--  valid wordcount
		result_text = " Words:" .. tostring(count)
	end
	-- set module string
	return "%#St_SelectMode#" .. "" .. "%#St_SelectModeCustomTxt#" .. result_text .. "%#St_SelectMode#" .. " "
end

return M

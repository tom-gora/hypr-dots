-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NvChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞
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
-- also on splits at least half the screen only the filename will be displayed
-- next to the root directory

---@return string
M.mode_plus_path = function()
	if not utils.is_activewin() then
		return ""
	end
	-- tweak normal mode
	modes["n"][3] = ""
	-- tweak visual modes
	modes["v"][3] = "󰬝"
	modes["Vs"][3] = "󰬝"
	modes["V"][3] = "󰬝"
	modes[""][3] = "󰬝"
	-- tweak insert modes
	modes["i"][3] = "󰬐"
	modes["ic"][3] = "󰬐"
	modes["ix"][3] = "󰬐"
	-- tweak terminal mode
	modes["t"][3] = '%{&buftype == "terminal" ? "  " : ""}'
	modes["nt"][3] = '%#St_NTerminalModeCustomTxt#%{&buftype == "terminal" ? "  " : ""}'

	local is_modified = function()
		return vim.bo.modified and " " or ""
	end

	local root_sep = ""
	local path_end_sep = " "
	local path_components = utils.path_formatter(root_sep, path_end_sep)
	local m = vim.api.nvim_get_mode().mode
	local component_string = "%#"
		.. modes[m][2]
		.. "#"
		.. "█"
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
		.. is_modified()
		.. path_components["path_end_sep"]
		.. "%#St_EmptySpace#"
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

	local added = (git_status.added and git_status.added ~= 0)
			and (" 󰐖 " .. utils.intToSuperscript(git_status.added))
		or ""
	local changed = (git_status.changed and git_status.changed ~= 0)
			and (" 󱊩 " .. utils.intToSuperscript(git_status.changed))
		or ""
	local removed = (git_status.removed and git_status.removed ~= 0)
			and (" 󰍵 " .. utils.intToSuperscript(git_status.removed))
		or ""
	local branch_name = "  " .. git_status.head

	local width = vim.api.nvim_win_get_width(0)
	if width < 62 then
		return "%#St_gitIcons#" .. added .. changed .. removed
	end

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
		return "%#St_macro_reg#  " .. recording_register .. " %#St_EmptySpace#"
	end
end

---@return string
M.lsp_diags = function()
	local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win() or 0)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if not utils.is_activewin() or not rawget(vim, "lsp") or not clients or #clients == 0 then
		return ""
	end
	local s = vim.diagnostic.severity

	local errors = #vim.diagnostic.get(utils.stbufnr(), { severity = s.ERROR })
	local warnings = #vim.diagnostic.get(utils.stbufnr(), { severity = s.WARN })
	local hints = #vim.diagnostic.get(utils.stbufnr(), { severity = s.HINT })
	local info = #vim.diagnostic.get(utils.stbufnr(), { severity = s.INFO })

	local total = errors + warnings + hints + info
	local width = vim.api.nvim_win_get_width(0)
	if width < 56 and total > 0 then
		return " 󰀧 "
	end

	if total == 0 then
		return " 󰺦 "
	end

	local e = (errors and errors > 0) and ("%#St_lspError#" .. utils.intToSuperscript(errors) .. " ") or ""
	local w = (warnings and warnings > 0) and ("%#St_lspWarning#" .. utils.intToSuperscript(warnings) .. " ") or ""
	local h = (hints and hints > 0) and ("%#St_lspHints#" .. utils.intToSuperscript(hints) .. " ") or ""
	local i = (info and info > 0) and ("%#St_lspInfo#" .. utils.intToSuperscript(info) .. " ") or ""

	return " " .. e .. w .. h .. i
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
	local width = vim.api.nvim_win_get_width(0)
	if width < 62 then
		return ""
	end
	--
	if lsp_string and lsp_string ~= "" then
		return (vim.o.columns > 86 and "%#St_ConfirmModeCustomTxt# " .. lsp_string.icon .. lsp_string.name)
			or "%#St_ConfirmMode#   "
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
	local line_col = string.format("%2d⏽%-2d", vim.fn.line("."), vim.fn.col("."))
	return "%#St_Pos_bg# " .. line_col .. " "
end

M.opened_buf_count = function()
	local bufs = vim.tbl_filter(function(bufnr)
		return vim.api.nvim_buf_get_option(bufnr, "buflisted")
	end, vim.api.nvim_list_bufs())
	if #bufs <= 1 then
		return ""
	elseif #bufs >= 3 and #bufs < 6 then
		return "%#Boolean# ⁺" .. utils.intToSuperscript(#bufs - 1)
	elseif #bufs >= 6 then
		return "%#ErrorMsg# ⁺" .. utils.intToSuperscript(#bufs - 1)
	end
	return "%#DiffAdd# ⁺" .. utils.intToSuperscript(#bufs - 1)
end

---@return string
M.ai_status = function()
	local ai_completions = "%#St_AI_Disabled#  "
	local aider = "%#St_AI_Disabled#▏󰭲 "
	if _G.COPILOT_ENABLED and _G.COPILOT_ENABLED == true then
		ai_completions = "%#St_AI_Cmp_Enabled#  "
	end
	if _G.AIDER_RUNNING and (not _G.AIDER_WRITING or _G.AIDER_WRITING == false) then
		aider = "%#St_AI_Chat_Enabled#▏󰅴 "
	elseif _G.AIDER_RUNNING and (_G.AIDER_WRITING and _G.AIDER_WRITING == true) then
		aider = "%#St_AI_Chat_Enabled#▏󰛓 "
	end
	return ai_completions .. aider
end

M.spelling_status = function()
	if utils.is_narrow_split() or not vim.wo.spell or vim.wo.spell == false then
		return ""
	end
	return "%#St_file_bg# " .. vim.o.spelllang .. " "
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
		result_text = " ..."
	else
		result_text = "#" .. tostring(count) .. " "
	end
	return "%#St_SelectModeCustomTxt# " .. result_text .. " "
end

return M

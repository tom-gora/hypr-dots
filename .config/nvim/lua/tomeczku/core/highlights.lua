-- helpers
local function modify_hl_group(hl_name, opts)
	local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })
	if ok then
		for k, v in pairs(opts) do
			hl_def[k] = v
			---@diagnostic disable-next-line: param-type-mismatch
			vim.api.nvim_set_hl(0, hl_name, hl_def)
		end
	end
end

local get_color = function(hl_name, arg)
	local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })
	if not ok then
		return
	end
	return hl_def[arg] or "NONE"
end

local darken = function(color, amount)
	amount = math.min(math.max(amount, 0), 1)

	local r = math.floor(color / (256 * 256))
	local g = math.floor((color / 256) % 256)
	local b = math.floor(color % 256)

	r = math.floor(r * (1 - amount))
	g = math.floor(g * (1 - amount))
	b = math.floor(b * (1 - amount))

	return r * 256 * 256 + g * 256 + b
end

local lighten = function(color, amount)
	amount = math.min(math.max(amount, 0), 1)

	local r = math.floor(color / (256 * 256))
	local g = math.floor((color / 256) % 256)
	local b = math.floor(color % 256)

	r = math.floor(r + (255 - r) * amount)
	g = math.floor(g + (255 - g) * amount)
	b = math.floor(b + (255 - b) * amount)

	return r * 256 * 256 + g * 256 + b
end

local function muted_variant(color)
	local r = math.floor(color / 2 ^ 16)
	local g = math.floor(color / 2 ^ 8) % 256
	local b = color % 256

	r = math.floor(r * 0.767)
	g = math.floor(g * 0.767)
	b = math.floor(b * 0.767)

	return r * 2 ^ 16 + g * 2 ^ 8 + b
end

local saturate = function(color, amount)
	amount = math.min(math.max(amount, 0), 1)

	local r = math.floor(color / (256 * 256))
	local g = math.floor((color / 256) % 256)
	local b = math.floor(color % 256)

	-- Convert RGB to HSL
	local max_val = math.max(r, g, b)
	local min_val = math.min(r, g, b)
	local l = (max_val + min_val) / 2

	local s = 0
	if max_val ~= min_val then
		s = (l < 128) and ((max_val - min_val) / (max_val + min_val))
			or ((max_val - min_val) / (2 * 255 - max_val - min_val))
	end

	local h = 0
	if max_val == r then
		h = (g - b) / (max_val - min_val)
	elseif max_val == g then
		h = 2 + (b - r) / (max_val - min_val)
	else
		h = 4 + (r - g) / (max_val - min_val)
	end
	h = (h * 60 + 360) % 360

	-- Increase saturation
	s = s + s * amount
	s = math.min(s, 1)

	-- Convert HSL back to RGB
	local c = (1 - math.abs(2 * l / 255 - 1)) * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = l / 255 - c / 2

	local r_prime, g_prime, b_prime
	if h < 60 then
		r_prime, g_prime, b_prime = c, x, 0
	elseif h < 120 then
		r_prime, g_prime, b_prime = x, c, 0
	elseif h < 180 then
		r_prime, g_prime, b_prime = 0, c, x
	elseif h < 240 then
		r_prime, g_prime, b_prime = 0, x, c
	elseif h < 300 then
		r_prime, g_prime, b_prime = x, 0, c
	else
		r_prime, g_prime, b_prime = c, 0, x
	end

	r = (r_prime + m) * 255
	g = (g_prime + m) * 255
	b = (b_prime + m) * 255

	return math.floor(r) * 256 * 256 + math.floor(g) * 256 + math.floor(b)
end

-- store new declarations make them dependant on theme declarations
local base_bg = get_color("Normal", "bg")
-- print(base_bg)
if base_bg == "NONE" then
	base_bg = 1644324
end
local dark_base_bg = darken(base_bg, 0.7)
local winbar_accent_primary = darken(get_color("String", "fg"), 0.65)
local err_bg
if get_color("CursorLineNr", "fg") == "NONE" then
	err_bg = saturate(lighten(get_color("Normal", "bg"), 0.2), 0.9)
else
	err_bg = get_color("CursorLineNr", "fg")
end
local muted_err_bg = muted_variant(get_color("ErrorMsg", "fg"))
local alt_err_bg
if get_color("DiffDelete", "fg") == "NONE" then
	alt_err_bg = get_color("Error", "fg")
else
	alt_err_bg = get_color("DiffDelete", "fg")
end
local muted_light_bg = muted_variant(lighten(get_color("Folded", "fg"), 0.2))
--some fallback for non nvchad specific highlights
local moon_teal = get_color("FloatBorder", "fg")
if moon_teal == "NONE" then
	moon_teal = get_color("PmenuSel", "bg")
end
local purple_fg = get_color("PmenuSel", "bg")
local green_fg = get_color("DiagnosticInfo", "fg")
local path_bg = lighten(base_bg, 0.06)
local intense_pink
-- another fallback for non nvchad specific highlights
if get_color("Label", "fg") == "NONE" then
	intense_pink = saturate(lighten(muted_err_bg, 0.2), 1)
else
	intense_pink = get_color("Label", "fg")
end
local yellow_warn = get_color("DiagnosticWarn", "fg")
local base_blue = get_color("DiffChange", "fg")
local select_mode_teal = lighten(moon_teal, 0.2)

local delimiters_yellow = saturate(darken(yellow_warn, 0.2), 0.8)
local delimiters_red = saturate(darken(get_color("ErrorMsg", "fg"), 0.2), 0.5)
local delimiters_orange = saturate(lighten(intense_pink, 0.2), 0.9)

local delimiters_teal = saturate(lighten(moon_teal, 0.2), 1)
local delimiters_green = saturate(lighten(green_fg, 0.2), 1)
local delimiters_purple = saturate(purple_fg, 0.8)
local delimiters_cyan = saturate(saturate(darken(purple_fg, 0.35), 1), 0.5)

-- HACK: upon more hacks upon hacks
-- after all this magic fuckery I am left to assume that no errors in default no theme install of base nvim mean
-- no dependencies on custom declared colors, or fallbacks in place and this should work with other themes
-- even if it looks shit then.... OOOFFF!!!

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	group = vim.api.nvim_create_augroup("Color", {}),
	pattern = "*",
	callback = function()
		-- hls for tabline
		modify_hl_group("BufferCurrentSignRight", { bg = "NONE", fg = winbar_accent_primary })
		modify_hl_group("BufferCurrentSign", { bg = "NONE", fg = winbar_accent_primary })
		modify_hl_group("BufferCurrent", { bg = winbar_accent_primary, bold = true })
		modify_hl_group("BufferCurrentIndex", { bg = winbar_accent_primary, bold = true })
		modify_hl_group("BufferCurrentMod", { fg = muted_err_bg, bg = winbar_accent_primary })
		modify_hl_group("BufferVisible", { fg = dark_base_bg, bg = muted_light_bg, bold = true })
		modify_hl_group("BufferVisibleMod", { fg = darken(alt_err_bg, 0.7), bg = muted_light_bg })
		modify_hl_group("BufferVisibleSign", { bg = "NONE", fg = muted_light_bg })
		modify_hl_group("BufferVisibleIndex", { fg = dark_base_bg, bg = muted_light_bg, bold = true })
		modify_hl_group("BufferTabpageFill", { link = "none", bg = "none", force = true })
		-- modifications to various float windows: telescope, oil etc
		modify_hl_group("FloatBorder", { bg = "NONE" })
		modify_hl_group("LspInfoBorder", { link = "FloatBorder", force = true })
		modify_hl_group("Float", { bg = "NONE" })
		modify_hl_group("NormalFloat", { bg = "NONE" })
		modify_hl_group("WhichKeyFloat", { bg = "NONE" })
		modify_hl_group("TelescopeBorder", { link = "FloatBorder", force = true })
		modify_hl_group("TelescopeTitle", { fg = purple_fg, link = "TelescopeTitle", force = true })
		modify_hl_group("LazyBackdrop", { bg = "NONE", force = true })
		modify_hl_group("TerminalNormal", { bg = "NONE", force = true })
		-- costom rainbow-delimiters colors (base rose-pine with bumped up saturation)
		modify_hl_group("RainbowDelimiterYellow", { fg = delimiters_yellow, force = true })
		modify_hl_group("RainbowDelimiterRed", { fg = delimiters_red, force = true })
		modify_hl_group("RainbowDelimiterOrange", { fg = delimiters_orange, force = true })
		modify_hl_group("RainbowDelimiterBlue", { fg = delimiters_teal, force = true })
		modify_hl_group("RainbowDelimiterGreen", { fg = delimiters_green, force = true })
		modify_hl_group("RainbowDelimiterViolet", { fg = delimiters_purple, force = true })
		modify_hl_group("RainbowDelimiterCyan", { fg = delimiters_cyan, force = true })
		-- highlights for statusline that I wrote for old nvchad config that I lifted and modified to my needs
		-- my custom hls used in this statusline config:
		modify_hl_group("St_NormalMode_Root_Sep", { bg = "NONE", fg = intense_pink, bold = false })
		modify_hl_group("St_VisualMode_Root_Sep", { bg = "NONE", fg = base_blue, bold = false })
		modify_hl_group("St_InsertMode_Root_Sep", { bg = dark_base_bg, fg = purple_fg, bold = false })
		modify_hl_group("St_ReplaceMode_Root_Sep", { bg = dark_base_bg, fg = yellow_warn, bold = false })
		modify_hl_group("St_SelectMode_Root_Sep", { bg = dark_base_bg, fg = base_blue, bold = false })
		modify_hl_group("St_CommandMode_Root_Sep", { bg = dark_base_bg, fg = green_fg, bold = false })
		modify_hl_group("St_ConfirmMode_Root_Sep", { bg = dark_base_bg, fg = select_mode_teal, bold = false })
		modify_hl_group("St_Root", { bg = dark_base_bg, fg = darken(err_bg, 0.2), bold = false })
		modify_hl_group("St_Root_Sep_Right", { bg = path_bg, fg = dark_base_bg, bold = false })
		modify_hl_group("St_NormalModeCustomTxt", { bg = intense_pink, fg = base_bg, bold = true })
		modify_hl_group("St_VisualModeCustomTxt", { bg = base_blue, fg = base_bg, bold = true })
		modify_hl_group("St_InsertModeCustomTxt", { bg = purple_fg, fg = base_bg, bold = true })
		modify_hl_group("St_ReplaceModeCustomTxt", { bg = yellow_warn, fg = base_bg, bold = true })
		modify_hl_group("St_SelectModeCustomTxt", { bg = base_blue, fg = base_bg, bold = true })
		modify_hl_group("St_CommandModeCustomTxt", { bg = green_fg, fg = base_bg, bold = true })
		modify_hl_group("St_ConfirmModeCustomTxt", { bg = select_mode_teal, fg = base_bg, bold = true })
		-- default hls used by nvchad extracted from that old config and injected into my config
		modify_hl_group("St_CommandMode", { bg = "NONE", bold = true, fg = green_fg })
		modify_hl_group("St_CommandModeCustomTxt", { bg = green_fg, bold = true, fg = base_bg })
		modify_hl_group("St_CommandModeSep", { bg = "NONE", bold = true, fg = green_fg })
		modify_hl_group("St_CommandMode_Root_Sep", { bg = dark_base_bg, fg = green_fg })
		modify_hl_group("St_CommandmodeText", { bg = path_bg, bold = true, fg = green_fg })
		modify_hl_group("St_ConfirmMode", { bg = "NONE", bold = true, fg = select_mode_teal })
		modify_hl_group("St_ConfirmModeCustomTxt", { bg = select_mode_teal, bold = true, fg = base_bg })
		modify_hl_group("St_ConfirmModeSep", { bg = "NONE", bold = true, fg = select_mode_teal })
		modify_hl_group("St_ConfirmMode_Root_Sep", { bg = dark_base_bg, fg = select_mode_teal })
		modify_hl_group("St_ConfirmmodeText", { bg = path_bg, bold = true, fg = select_mode_teal })
		modify_hl_group("St_EmptySpace", { fg = base_bg })
		modify_hl_group("St_EmptySpace2", { fg = base_bg })
		modify_hl_group("St_InsertMode", { bg = "NONE", bold = true, fg = purple_fg })
		modify_hl_group("St_InsertModeCustomTxt", { bg = purple_fg, bold = true, fg = base_bg })
		modify_hl_group("St_InsertModeSep", { bg = "NONE", bold = true, fg = purple_fg })
		modify_hl_group("St_InsertMode_Root_Sep", { bg = dark_base_bg, fg = purple_fg })
		modify_hl_group("St_InsertmodeText", { bg = path_bg, bold = true, fg = purple_fg })
		modify_hl_group("St_LspHints", { fg = purple_fg })
		modify_hl_group("St_LspInfo", { fg = green_fg })
		modify_hl_group("St_LspProgress", { fg = green_fg })
		modify_hl_group("St_LspStatus_Icon", { bg = base_blue, fg = base_bg })
		modify_hl_group("St_NTerminalMode", { bg = "NONE", bold = true, fg = intense_pink })
		modify_hl_group(
			"St_NTerminalModeCustomTxt",
			{ bg = get_color("St_NTerminalMode", "fg"), bold = true, fg = base_bg }
		)
		modify_hl_group("St_NTerminalModeSep", { bg = "NONE", bold = true, fg = yellow_warn })
		modify_hl_group("St_NTerminalMode_Root_Sep", { bg = "NONE", fg = intense_pink })
		modify_hl_group("St_NTerminalmodeText", { bg = path_bg, bold = true, fg = yellow_warn })
		modify_hl_group("St_NormalMode", { bg = "NONE", bold = true, fg = intense_pink })
		modify_hl_group("St_NormalModeCustomTxt", { bg = intense_pink, bold = true, fg = base_bg })
		modify_hl_group("St_NormalModeSep", { bg = "NONE", bold = true, fg = base_blue })
		modify_hl_group("St_NormalMode_Root_Sep", { bg = dark_base_bg, fg = intense_pink })
		modify_hl_group("St_NormalmodeText", { bg = path_bg, fg = intense_pink })
		modify_hl_group("St_Pos_bg", { bg = yellow_warn, fg = base_bg })
		modify_hl_group("St_Pos_sep", { bg = "NONE", fg = yellow_warn })
		modify_hl_group("St_Pos_txt", { bg = path_bg, fg = yellow_warn })
		modify_hl_group("St_ReplaceMode", { bg = "NONE", bold = true, fg = yellow_warn })
		modify_hl_group("St_ReplaceModeCustomTxt", { bg = yellow_warn, bold = true, fg = base_bg })
		modify_hl_group("St_ReplaceModeSep", { bg = "NONE", bold = true, fg = yellow_warn })
		modify_hl_group("St_ReplaceMode_Root_Sep", { bg = dark_base_bg, fg = yellow_warn })
		modify_hl_group("St_ReplacemodeText", { bg = path_bg, bold = true, fg = yellow_warn })
		modify_hl_group("St_SelectMode", { bg = "NONE", bold = true, fg = base_blue })
		modify_hl_group("St_SelectModeCustomTxt", { bg = base_blue, bold = true, fg = base_bg })
		modify_hl_group("St_SelectModeSep", { bg = "NONE", bold = true, fg = base_blue })
		modify_hl_group("St_SelectMode_Root_Sep", { bg = dark_base_bg, fg = base_blue })
		modify_hl_group("St_SelectmodeText", { bg = path_bg, bold = true, fg = base_blue })
		modify_hl_group("St_TerminalMode", { bg = "NONE", bold = true, fg = green_fg })
		modify_hl_group("St_TerminalModeCustomTxt", { bg = green_fg, bold = true, fg = base_bg })
		modify_hl_group("St_TerminalModeSep", { bg = "NONE", bold = true, fg = green_fg })
		modify_hl_group("St_TerminalMode_Root_Sep", { bg = "NONE", fg = green_fg })
		modify_hl_group("St_TerminalmodeText", { bg = path_bg, bold = true, fg = green_fg })
		modify_hl_group("St_VisualMode", { bg = "NONE", bold = true, fg = base_blue })
		modify_hl_group("St_VisualModeCustomTxt", { bg = base_blue, bold = true, fg = base_bg })
		modify_hl_group("St_VisualModeSep", { bg = "NONE", bold = true, fg = base_blue })
		modify_hl_group("St_VisualMode_Root_Sep", { bg = dark_base_bg, fg = base_blue })
		modify_hl_group("St_VisualmodeText", { bg = path_bg, bold = true, fg = base_blue })
		modify_hl_group("St_cwd_bg", { bg = yellow_warn, fg = base_bg })
		modify_hl_group("St_cwd_sep", { bg = "NONE", fg = yellow_warn })
		modify_hl_group("St_cwd_txt", { bg = path_bg, fg = yellow_warn })
		modify_hl_group("St_file_bg", { bg = err_bg, fg = base_bg })
		modify_hl_group("St_file_info", { fg = err_bg })
		modify_hl_group("St_file_sep", { bg = "NONE", fg = err_bg })
		modify_hl_group("St_file_txt", { bg = path_bg, fg = err_bg })
		modify_hl_group("St_gitIcons", { bold = true, fg = muted_light_bg })
		modify_hl_group("St_lspError", { fg = err_bg })
		modify_hl_group("St_lspWarning", { fg = yellow_warn })
		modify_hl_group("St_lsp_bg", { bg = green_fg, fg = base_bg })
		modify_hl_group("St_lsp_sep", { bg = "NONE", fg = green_fg })
		modify_hl_group("St_lsp_txt", { bg = path_bg, fg = green_fg })
		modify_hl_group("St_sep_r", { fg = path_bg })
		modify_hl_group("St_macro_sep", { fg = path_bg, bg = "none" })
		modify_hl_group("St_macro_reg", { bg = path_bg, fg = get_color("ErrorMsg", "fg") })
		--
		-- nvim notify:
		modify_hl_group("NotifyERRORBorder", { fg = muted_variant(err_bg), force = true })
		modify_hl_group("NotifyWARNBorder", { fg = muted_variant(yellow_warn), force = true })
		modify_hl_group("NotifyINFOBorder", { fg = muted_variant(moon_teal), force = true })
		modify_hl_group("NotifyDEBUGBorder", { fg = muted_variant(muted_light_bg), force = true })
		modify_hl_group("NotifyTRACEBorder", { fg = muted_variant(purple_fg), force = true })
		modify_hl_group("NotifyERRORIcon", { fg = err_bg, force = true })
		modify_hl_group("NotifyWARNIcon", { fg = yellow_warn, force = true })
		modify_hl_group("NotifyINFOIcon", { fg = moon_teal, force = true })
		modify_hl_group("NotifyDEBUGIcon", { fg = muted_light_bg, force = true })
		modify_hl_group("NotifyTRACEIcon", { fg = purple_fg, force = true })
		modify_hl_group("NotifyERRORTitle", { fg = err_bg, force = true })
		modify_hl_group("NotifyWARNTitle", { fg = yellow_warn, force = true })
		modify_hl_group("NotifyINFOTitle", { fg = moon_teal, force = true })
		modify_hl_group("NotifyDEBUGTitle", { fg = muted_light_bg, force = true })
		modify_hl_group("NotifyTRACETitle", { fg = purple_fg, force = true })

		-- miniindentscope indentation guides
		modify_hl_group("MiniIndentscopeSymbol", { link = "BufferVisibleSign", force = true })
		-- supermaven icon
		modify_hl_group("CmpItemKindSupermaven", { link = "DevIconXz", force = true })
		modify_hl_group("ToggleTerm1Normal", { bg = purple_fg, force = true })
		modify_hl_group("ToggleTerm1StatusLine", { bg = "NONE", force = true })
		-- adjust lspsaga beacon
		modify_hl_group("SagaBeacon", { bg = delimiters_teal, force = true })
	end,
})

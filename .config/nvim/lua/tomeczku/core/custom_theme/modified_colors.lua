local h, M = require("tomeczku.core.custom_theme.helpers"), {}

M = {
	base_bg = function()
		local b = h.get_color("Normal", "bg")
		if b == "NONE" then
			return 1644324
		end
		return b
	end,

	low_dark_base_bg = function()
		local b = M.base_bg()
		return type(b) == "number" and h.darken(b, 0.2) or nil
	end,

	dark_base_bg = function()
		local b = M.base_bg()
		return type(b) == "number" and h.darken(b, 0.7) or nil
	end,

	winbar_accent_primary = function()
		local color = h.get_color("String", "fg")
		return type(color) == "number" and h.darken(color, 0.65) or nil
	end,

	err_bg = function()
		local cursor_line_nr_fg = h.get_color("CursorLineNr", "fg")
		if cursor_line_nr_fg == "NONE" then
			local normal_bg = h.get_color("Normal", "bg")
			return type(normal_bg) == "number" and h.saturate(h.lighten(normal_bg, 0.2), 0.9) or nil
		else
			return cursor_line_nr_fg
		end
	end,

	muted_err_bg = function()
		local color = h.get_color("ErrorMsg", "fg")
		return type(color) == "number" and h.muted_variant(color) or nil
	end,

	alt_err_bg = function()
		local diff_delete_fg = h.get_color("DiffDelete", "fg")
		if diff_delete_fg == "NONE" then
			return h.get_color("Error", "fg")
		else
			return diff_delete_fg
		end
	end,

	muted_light_bg = function()
		local folded_fg = h.get_color("Folded", "fg")
		return type(folded_fg) == "number" and h.muted_variant(h.lighten(folded_fg, 0.2)) or nil
	end,

	moon_teal = function()
		local color = h.get_color("FloatBorder", "fg")
		if color == "NONE" then
			return h.get_color("PmenuSel", "bg")
		else
			return color
		end
	end,

	purple_fg = function()
		return h.get_color("PmenuSel", "bg")
	end,

	green_fg = function()
		return h.get_color("DiagnosticInfo", "fg")
	end,

	path_bg = function()
		local b = M.base_bg()
		return type(b) == "number" and h.lighten(b, 0.06) or nil
	end,

	intense_pink = function()
		local label_fg = h.get_color("Label", "fg")
		if label_fg == "NONE" then
			local muted = M.muted_err_bg()
			return type(muted) == "number" and h.saturate(h.lighten(muted, 0.2), 1) or nil
		else
			return label_fg
		end
	end,

	yellow_warn = function()
		return h.get_color("DiagnosticWarn", "fg")
	end,

	---@diagnostic disable-next-line: undefined-doc-name
	---@return string| vim.api.keyset.hl_info?
	base_blue = function()
		return h.get_color("DiffChange", "fg")
	end,

	select_mode_teal = function()
		local color = M.moon_teal()
		return type(color) == "number" and h.lighten(color, 0.2) or nil
	end,

	delimiters_yellow = function()
		local yellow = M.yellow_warn()
		return type(yellow) == "number" and h.saturate(h.darken(yellow, 0.2), 0.8) or nil
	end,

	delimiters_red = function()
		local color = h.get_color("ErrorMsg", "fg")
		return type(color) == "number" and h.saturate(h.darken(color, 0.2), 0.5) or nil
	end,

	delimiters_orange = function()
		local color = M.intense_pink()
		return type(color) == "number" and h.saturate(h.lighten(color, 0.2), 0.9) or nil
	end,

	delimiters_teal = function()
		local color = M.moon_teal()
		local lightened = type(color) == "number" and h.lighten(color, 0.2) or nil
		return type(lightened) == "number" and h.saturate(lightened, 1) or nil
	end,

	delimiters_green = function()
		local color = M.green_fg()
		local lightened = type(color) == "number" and h.lighten(color, 0.2) or nil
		return type(lightened) == "number" and h.saturate(lightened, 1) or nil
	end,

	delimiters_purple = function()
		local color = M.purple_fg()
		return type(color) == "number" and h.saturate(color, 0.8) or nil
	end,

	delimiters_cyan = function()
		local color = M.purple_fg()
		local darkened = type(color) == "number" and h.darken(color, 0.35) or nil
		local saturated1 = type(darkened) == "number" and h.saturate(darkened, 1) or nil
		return type(saturated1) == "number" and h.saturate(saturated1, 0.5) or nil
	end,

	line_nr_red = function()
		local color = h.get_color("ErrorMsg", "fg")
		return type(color) == "number" and h.darken(color, 0.2) or nil
	end,

	line_nr_teal = function()
		local color = h.get_color("Special", "fg")
		return type(color) == "number" and h.darken(color, 0.2) or nil
	end,

	indent_lines = function()
		local color = M.purple_fg()
		return type(color) == "number" and h.darken(color, 0.3) or nil
	end,

	diag_bg_info = function()
		local color = h.get_color("LspDiagnosticsFloatingInfo", "fg")
		return type(color) == "number" and h.darken(color, 0.90)
	end,

	diag_bg_hint = function()
		local color = h.get_color("LspDiagnosticsFloatingHint", "fg")
		return type(color) == "number" and h.darken(color, 0.90)
	end,

	diag_bg_warn = function()
		local color = h.get_color("LspDiagnosticsFloatingWarning", "fg")
		return type(color) == "number" and h.darken(color, 0.90)
	end,

	diag_bg_error = function()
		local color = h.get_color("LspDiagnosticsFloatingError", "fg")
		return type(color) == "number" and h.muted_variant(h.darken(color, 0.90))
	end,
}

return M

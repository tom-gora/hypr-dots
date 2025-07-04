-- theme variation lifted from NvChad's base46 selection as I like their colors better thn defaault rose-pine
--
local b46 = require("tomeczku.core.custom_theme.base46_palette")
local h, mod = require("tomeczku.core.custom_theme.helpers"), require("tomeczku.core.custom_theme.modified_colors")

local hl = vim.api.nvim_set_hl
local theme = {}

---@diagnostic disable: assign-type-mismatch
theme.set_highlights = function()
	--
	-- ██████╗░░█████╗░░██████╗███████╗░░██╗██╗░█████╗░
	-- ██╔══██╗██╔══██╗██╔════╝██╔════╝░██╔╝██║██╔═══╝░
	-- ██████╦╝███████║╚█████╗░█████╗░░██╔╝░██║██████╗░
	-- ██╔══██╗██╔══██║░╚═══██╗██╔══╝░░███████║██╔══██╗
	-- ██████╦╝██║░░██║██████╔╝███████╗╚════██║╚█████╔╝
	-- ╚═════╝░╚═╝░░╚═╝╚═════╝░╚══════╝░░░░░╚═╝░╚════╝░
	--
	-- ██╗░░██╗██╗░██████╗░██╗░░██╗██╗░░░░░██╗░██████╗░██╗░░██╗████████╗░██████╗
	-- ██║░░██║██║██╔════╝░██║░░██║██║░░░░░██║██╔════╝░██║░░██║╚══██╔══╝██╔════╝
	-- ███████║██║██║░░██╗░███████║██║░░░░░██║██║░░██╗░███████║░░░██║░░░╚█████╗░
	-- ██╔══██║██║██║░░╚██╗██╔══██║██║░░░░░██║██║░░╚██╗██╔══██║░░░██║░░░░╚═══██╗
	-- ██║░░██║██║╚██████╔╝██║░░██║███████╗██║╚██████╔╝██║░░██║░░░██║░░░██████╔╝
	-- ╚═╝░░╚═╝╚═╝░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░
	--
	hl(0, "Normal", { fg = b46.base05, bg = b46.base00 })
	hl(0, "SignColumn", { fg = b46.base03, bg = "NONE", sp = "NONE" })
	hl(0, "MsgArea", { fg = b46.base05, bg = b46.base00 })
	hl(0, "ModeMsg", { fg = b46.base0B, bg = "NONE" })
	hl(0, "MsgSeparator", { fg = b46.base05, bg = b46.base00 })
	hl(0, "SpellBad", { fg = "NONE", bg = "NONE", sp = b46.base08, undercurl = true })
	hl(0, "SpellCap", { fg = "NONE", bg = "NONE", sp = b46.base0D, undercurl = true })
	hl(0, "SpellLocal", { fg = "NONE", bg = "NONE", sp = b46.base0C, undercurl = true })
	hl(0, "SpellRare", { fg = "NONE", bg = "NONE", sp = b46.base0D, undercurl = true })
	hl(0, "NormalNC", { fg = b46.base05, bg = b46.base00 })
	hl(0, "Pmenu", { fg = "NONE", bg = b46.one_bg })
	hl(0, "PmenuSel", { fg = b46.black, bg = b46.pmenu_bg })
	hl(0, "WildMenu", { fg = b46.base08, bg = b46.base0A })
	hl(0, "CursorLineNr", { fg = b46.white, bg = "NONE" })
	hl(0, "Comment", { fg = b46.grey_fg, bg = "NONE", italic = true })
	hl(0, "Folded", { fg = b46.base03, bg = b46.base01 })
	hl(0, "FoldColumn", { fg = b46.base0C, bg = b46.base01 })
	hl(0, "LineNr", { fg = b46.grey, bg = "NONE" })
	hl(0, "FloatBorder", { fg = b46.moon_teal, bg = mod.low_dark_base_bg() })
	hl(0, "VertSplit", { fg = b46.line, bg = "NONE" })
	hl(0, "CursorLine", { fg = "NONE", bg = b46.lighter_black })
	hl(0, "CursorColumn", { fg = "NONE", bg = b46.black2 })
	hl(0, "ColorColumn", { fg = "NONE", bg = b46.black2 })
	hl(0, "NormalFloat", { fg = "NONE", bg = mod.low_dark_base_bg() })
	hl(0, "Visual", { fg = "NONE", bg = b46.base02 })
	hl(0, "VisualNOS", { fg = b46.base08, bg = "NONE" })
	hl(0, "WarningMsg", { fg = b46.base08, bg = "NONE" })
	hl(0, "DiffAdd", { fg = b46.vibrant_green, bg = "NONE" })
	hl(0, "DiffChange", { fg = b46.blue, bg = "NONE" })
	hl(0, "DiffDelete", { fg = b46.red, bg = "NONE" })
	hl(0, "QuickFixLine", { fg = "NONE", bg = b46.base01, sp = "NONE" })
	hl(0, "PmenuSbar", { fg = "NONE", bg = b46.one_bg })
	hl(0, "PmenuThumb", { fg = "NONE", bg = b46.grey })
	hl(0, "MatchWord", { fg = b46.white, bg = b46.grey })
	hl(0, "MatchParen", { link = "MatchWord" })
	hl(0, "Cursor", { fg = b46.base00, bg = b46.base05 })
	hl(0, "Conceal", { fg = "NONE", bg = "NONE" })
	hl(0, "Directory", { fg = b46.base0D, bg = "NONE" })
	hl(0, "SpecialKey", { fg = b46.base03, bg = "NONE" })
	hl(0, "Title", { fg = b46.base0D, bg = mod.low_dark_base_bg(), sp = "NONE" })
	hl(0, "ErrorMsg", { fg = b46.base08, bg = b46.base00 })
	hl(0, "Search", { fg = b46.base01, bg = b46.base0A })
	hl(0, "IncSearch", { fg = b46.base01, bg = b46.base09 })
	hl(0, "Substitute", { fg = b46.base01, bg = b46.base0A, sp = "NONE" })
	hl(0, "MoreMsg", { fg = b46.base0B, bg = "NONE" })
	hl(0, "Question", { fg = b46.base0D, bg = "NONE" })
	hl(0, "NonText", { fg = b46.base03, bg = "NONE" })
	hl(0, "Variable", { fg = b46.base05, bg = "NONE" })
	hl(0, "String", { fg = b46.base0B, bg = "NONE" })
	hl(0, "Character", { fg = b46.base08, bg = "NONE" })
	hl(0, "Constant", { fg = b46.base08, bg = "NONE" })
	hl(0, "LineNumber", { fg = b46.base09, bg = "NONE" })
	hl(0, "Boolean", { fg = b46.base09, bg = "NONE" })
	hl(0, "Float", { fg = b46.base09, bg = "NONE" })
	hl(0, "Identifier", { fg = b46.base08, bg = "NONE", sp = "NONE" })
	hl(0, "Function", { fg = b46.base0D, bg = "NONE" })
	hl(0, "Operator", { fg = b46.base05, bg = "NONE", sp = "NONE" })
	hl(0, "Type", { fg = b46.base0A, bg = "NONE", sp = "NONE" })
	hl(0, "StorageClass", { fg = b46.base0A, bg = "NONE" })
	hl(0, "Structure", { fg = b46.base0E, bg = "NONE" })
	hl(0, "Typedef", { fg = b46.base0A, bg = "NONE" })
	hl(0, "Keyword", { fg = b46.base0E, bg = "NONE" })
	hl(0, "Statement", { fg = b46.base08, bg = "NONE" })
	hl(0, "Conditional", { fg = b46.base0E, bg = "NONE" })
	hl(0, "Repeat", { fg = b46.base0A, bg = "NONE" })
	hl(0, "Label", { fg = b46.moon_pink, bg = "NONE" })
	hl(0, "Exception", { fg = b46.base08, bg = "NONE" })
	hl(0, "Include", { fg = b46.base0D, bg = "NONE" })
	hl(0, "PreProc", { fg = b46.base0A, bg = "NONE" })
	hl(0, "Define", { fg = b46.base0E, bg = "NONE", sp = "NONE" })
	hl(0, "Macro", { fg = b46.base08, bg = "NONE" })
	hl(0, "Special", { fg = b46.base0C, bg = "NONE" })
	hl(0, "SpecialChar", { fg = b46.base0F, bg = "NONE" })
	hl(0, "Tag", { fg = b46.base0A, bg = "NONE" })
	hl(0, "Debug", { fg = b46.base08, bg = "NONE" })
	hl(0, "Underlined", { fg = b46.base0B, bg = "NONE" })
	hl(0, "Bold", { fg = "NONE", bg = "NONE", bold = true })
	hl(0, "Italic", { fg = "NONE", bg = "NONE", italic = true })
	hl(0, "Ignore", { fg = b46.cyan, bg = b46.base00, bold = true })
	hl(0, "Todo", { fg = b46.base0A, bg = b46.base01 })
	hl(0, "Error", { fg = b46.base00, bg = b46.base08 })
	-- Treesitter
	hl(0, "@annotation", { fg = b46.base0F, bg = "NONE" })
	hl(0, "@attribute", { fg = b46.base0A, bg = "NONE" })
	hl(0, "@constructor", { fg = b46.base0C, bg = "NONE" })
	hl(0, "@type.builtin", { fg = b46.base0A, bg = "NONE" })
	hl(0, "@conditional", { link = "Conditional" })
	hl(0, "@exception", { fg = b46.base08, bg = "NONE" })
	hl(0, "@include", { link = "Include" })
	hl(0, "@keyword.return", { fg = b46.base0E, bg = "NONE" })
	hl(0, "@keyword", { fg = b46.base0E, bg = "NONE" })
	hl(0, "@keyword.function", { fg = b46.base0E, bg = "NONE" })
	hl(0, "@namespace", { fg = b46.base08, bg = "NONE" })
	hl(0, "@constant.builtin", { fg = b46.base09, bg = "NONE" })
	hl(0, "@float", { fg = b46.base09, bg = "NONE" })
	hl(0, "@character", { fg = b46.base08, bg = "NONE" })
	hl(0, "@error", { fg = b46.base08, bg = "NONE" })
	hl(0, "@function", { fg = b46.base0D, bg = "NONE" })
	hl(0, "@function.builtin", { fg = b46.base0D, bg = "NONE" })
	hl(0, "@method", { fg = b46.base0D, bg = "NONE" })
	hl(0, "@constant.macro", { fg = b46.base08, bg = "NONE" })
	hl(0, "@function.macro", { fg = b46.base08, bg = "NONE" })
	hl(0, "@variable", { fg = b46.base05, bg = "NONE" })
	hl(0, "@variable.builtin", { fg = b46.base09, bg = "NONE" })
	hl(0, "@property", { fg = b46.base08, bg = "NONE" })
	hl(0, "@field", { fg = b46.base0D, bg = "NONE" })
	hl(0, "@parameter", { fg = b46.base08, bg = "NONE" })
	hl(0, "@parameter.reference", { fg = b46.base05, bg = "NONE" })
	hl(0, "@symbol", { fg = b46.base0B, bg = "NONE" })
	hl(0, "@text", { fg = b46.base05, bg = "NONE" })
	hl(0, "@punctuation.delimiter", { fg = b46.base0F, bg = "NONE" })
	hl(0, "@tag.delimiter", { fg = b46.base0F, bg = "NONE" })
	hl(0, "@tag.attribute", { link = "@Property" })
	hl(0, "@punctuation.bracket", { fg = b46.base0F, bg = "NONE" })
	hl(0, "@punctuation.special", { fg = b46.base08, bg = "NONE" })
	hl(0, "@string.regex", { fg = b46.base0C, bg = "NONE" })
	hl(0, "@string.escape", { fg = b46.base0C, bg = "NONE" })
	hl(0, "@emphasis", { fg = b46.base09, bg = "NONE" })
	hl(0, "@literal", { fg = b46.base09, bg = "NONE" })
	hl(0, "@text.uri", { fg = b46.base09, bg = "NONE" })
	hl(0, "@keyword.operator", { fg = b46.base0E, bg = "NONE" })
	hl(0, "@strong", { fg = "NONE", bg = "NONE", bold = true })
	hl(0, "@scope", { fg = "NONE", bg = "NONE", bold = true })
	hl(0, "TreesitterContext", { link = "CursorLine" })
	-- markdown
	hl(0, "markdownBlockquote", { fg = b46.green, bg = "NONE" })
	hl(0, "markdownCode", { fg = b46.orange, bg = "NONE" })
	hl(0, "markdownCodeBlock", { fg = b46.orange, bg = "NONE" })
	hl(0, "markdownCodeDelimiter", { fg = b46.orange, bg = "NONE" })
	hl(0, "markdownH1", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownH2", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownH3", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownH4", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownH5", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownH6", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownHeadingDelimiter", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownHeadingRule", { fg = b46.base05, bg = "NONE", bold = true })
	hl(0, "markdownId", { fg = b46.purple, bg = "NONE" })
	hl(0, "markdownIdDeclaration", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownIdDelimiter", { fg = b46.light_grey, bg = "NONE" })
	hl(0, "markdownLinkDelimiter", { fg = b46.light_grey, bg = "NONE" })
	hl(0, "markdownBold", { fg = b46.blue, bg = "NONE", bold = true })
	hl(0, "markdownItalic", { fg = "NONE", bg = "NONE", italic = true })
	hl(0, "markdownBoldItalic", { fg = b46.yellow, bg = "NONE", bold = true, italic = true })
	hl(0, "markdownListMarker", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownOrderedListMarker", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownRule", { fg = b46.base01, bg = "NONE" })
	hl(0, "markdownUrl", { fg = b46.cyan, bg = "NONE", underline = true })
	hl(0, "markdownLinkText", { fg = b46.blue, bg = "NONE" })
	hl(0, "markdownFootnote", { fg = b46.orange, bg = "NONE" })
	hl(0, "markdownFootnoteDefinition", { fg = b46.orange, bg = "NONE" })
	hl(0, "markdownEscape", { fg = b46.yellow, bg = "NONE" })
	-- Whichkey
	hl(0, "WhichKey", { fg = b46.blue, bg = "NONE" })
	hl(0, "WhichKeySeperator", { fg = b46.light_grey, bg = "NONE" })
	hl(0, "WhichKeyDesc", { fg = b46.red, bg = "NONE" })
	hl(0, "WhichKeyGroup", { fg = b46.green, bg = "NONE" })
	hl(0, "WhichKeyValue", { fg = b46.green, bg = "NONE" })
	hl(0, "WhichKeyFloat", { link = "NormalFloat" })
	-- Git
	hl(0, "SignAdd", { fg = b46.green, bg = "NONE" })
	hl(0, "SignChange", { fg = b46.blue, bg = "NONE" })
	hl(0, "SignDelete", { fg = b46.red, bg = "NONE" })
	hl(0, "GitSignsAdd", { fg = b46.green, bg = "NONE" })
	hl(0, "GitSignsChange", { fg = b46.blue, bg = "NONE" })
	hl(0, "GitSignsDelete", { fg = b46.red, bg = "NONE" })
	-- LSP
	hl(0, "DiagnosticError", { fg = b46.base08, bg = "NONE" })
	hl(0, "DiagnosticWarning", { fg = b46.base09, bg = "NONE" })
	hl(0, "DiagnosticHint", { fg = b46.purple, bg = "NONE" })
	hl(0, "DiagnosticWarn", { fg = b46.yellow, bg = "NONE" })
	hl(0, "DiagnosticInfo", { fg = b46.green, bg = "NONE" })
	hl(0, "LspDiagnosticsDefaultError", { fg = b46.base08, bg = "NONE" })
	hl(0, "LspDiagnosticsDefaultWarning", { fg = b46.base09, bg = "NONE" })
	hl(0, "LspDiagnosticsDefaultInformation", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsDefaultInfo", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsDefaultHint", { fg = b46.purple, bg = "NONE" })
	hl(0, "LspDiagnosticsFloatingError", { fg = b46.base08, bg = "NONE" })
	hl(0, "LspDiagnosticsFloatingWarning", { fg = b46.base09, bg = "NONE" })
	hl(0, "LspDiagnosticsFloatingInformation", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsFloatingInfo", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsFloatingHint", { fg = b46.purple, bg = "NONE" })
	hl(0, "DiagnosticSignError", { fg = b46.base08, bg = "NONE" })
	hl(0, "DiagnosticSignWarning", { fg = b46.base09, bg = "NONE" })
	hl(0, "DiagnosticSignInformation", { fg = b46.sun, bg = "NONE" })
	hl(0, "DiagnosticSignInfo", { fg = b46.sun, bg = "NONE" })
	hl(0, "DiagnosticSignHint", { fg = b46.purple, bg = "NONE" })
	hl(0, "LspDiagnosticsSignError", { fg = b46.base08, bg = "NONE" })
	hl(0, "LspDiagnosticsSignWarning", { fg = b46.base09, bg = "NONE" })
	hl(0, "LspDiagnosticsSignInformation", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsSignInfo", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsSignHint", { fg = b46.purple, bg = "NONE" })
	hl(0, "LspDiagnosticsError", { fg = b46.base08, bg = "NONE" })
	hl(0, "LspDiagnosticsWarning", { fg = b46.base09, bg = "NONE" })
	hl(0, "LspDiagnosticsInformation", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsInfo", { fg = b46.sun, bg = "NONE" })
	hl(0, "LspDiagnosticsHint", { fg = b46.purple, bg = "NONE" })
	hl(0, "LspDiagnosticsUnderlineError", { fg = "NONE", bg = "NONE", underline = true })
	hl(0, "LspDiagnosticsUnderlineWarning", { fg = "NONE", bg = "NONE", underline = true })
	hl(0, "LspDiagnosticsUnderlineInformation", { fg = "NONE", bg = "NONE", underline = true })
	hl(0, "LspDiagnosticsUnderlineInfo", { fg = "NONE", bg = "NONE", underline = true })
	hl(0, "LspDiagnosticsUnderlineHint", { fg = "NONE", bg = "NONE", underline = true })
	hl(0, "LspReferenceRead", { fg = "NONE", bg = "#2e303b" })
	hl(0, "LspReferenceText", { fg = "NONE", bg = "#2e303b" })
	hl(0, "LspReferenceWrite", { fg = "NONE", bg = "#2e303b" })
	hl(0, "LspCodeLens", { fg = b46.base04, bg = "NONE", italic = true })
	hl(0, "LspCodeLensSeparator", { fg = b46.base04, bg = "NONE", italic = true })

	hl(0, "NotifyBackground", { bg = mod.dark_base_bg(), focer })
	local notify_error_hls = {
		"NotifyERRORBorder",
		"NotifyERRORIcon",
		"NotifyERRORBody",
		"NotifyERRORTitle",
	}
	local notify_warn_hls = {
		"NotifyWARNIcon",
		"NotifyWARNBorder",
		"NotifyWARNBody",
		"NotifyWARNTitle",
	}
	local notify_info_hls = {
		"NotifyINFOBorder",
		"NotifyINFOIcon",
		"NotifyINFOBody",
		"NotifyINFOTitle",
	}
	local notify_debug_hls = {
		"NotifyDEBUGTitle",
		"NotifyDEBUGIcon",
		"NotifyDEBUGBorder",
		"NotifyDEBUGBody",
	}
	local notify_trace_hls = {
		"NotifyTRACETitle",
		"NotifyTRACEBody",
		"NotifyTRACEIcon",
		"NotifyTRACEBorder",
	}

	for _, hl_name in ipairs(notify_error_hls) do
		hl(0, hl_name, { fg = b46.red, bg = mod.low_dark_base_bg(), bold = true })
	end
	for _, hl_name in ipairs(notify_warn_hls) do
		hl(0, hl_name, { fg = b46.yellow, bg = mod.low_dark_base_bg(), bold = true })
	end
	for _, hl_name in ipairs(notify_info_hls) do
		hl(0, hl_name, { fg = b46.blue, bg = mod.low_dark_base_bg(), bold = true })
	end
	for _, hl_name in ipairs(notify_debug_hls) do
		hl(0, hl_name, { fg = b46.purple, bg = mod.low_dark_base_bg(), bold = true })
	end
	for _, hl_name in ipairs(notify_trace_hls) do
		hl(0, hl_name, { fg = b46.cyan, bg = mod.low_dark_base_bg(), bold = true })
	end

	-- Cmp
	hl(0, "CmpItemAbbrDeprecated", { fg = b46.grey, bg = "NONE", strikethrough = true })
	hl(0, "CmpItemAbbrMatch", { fg = b46.blue, bg = "NONE" })
	hl(0, "CmpItemAbbrMatchFuzzy", { fg = b46.blue, bg = "NONE" })
	hl(0, "CmpItemKindFunction", { fg = b46.blue, bg = "NONE" })
	hl(0, "CmpItemKindMethod", { fg = b46.blue, bg = "NONE" })
	hl(0, "CmpItemKindConstructor", { fg = b46.cyan, bg = "NONE" })
	hl(0, "CmpItemKindClass", { fg = b46.cyan, bg = "NONE" })
	hl(0, "CmpItemKindEnum", { fg = b46.cyan, bg = "NONE" })
	hl(0, "CmpItemKindEvent", { fg = b46.yellow, bg = "NONE" })
	hl(0, "CmpItemKindInterface", { fg = b46.cyan, bg = "NONE" })
	hl(0, "CmpItemKindStruct", { fg = b46.cyan, bg = "NONE" })
	hl(0, "CmpItemKindVariable", { fg = b46.red, bg = "NONE" })
	hl(0, "CmpItemKindField", { fg = b46.red, bg = "NONE" })
	hl(0, "CmpItemKindProperty", { fg = b46.red, bg = "NONE" })
	hl(0, "CmpItemKindEnumMember", { fg = b46.orange, bg = "NONE" })
	hl(0, "CmpItemKindConstant", { fg = b46.orange, bg = "NONE" })
	hl(0, "CmpItemKindKeyword", { fg = b46.purple, bg = "NONE" })
	hl(0, "CmpItemKindModule", { fg = b46.cyan, bg = "NONE" })
	hl(0, "CmpItemKindValue", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindUnit", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindText", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindSnippet", { fg = b46.yellow, bg = "NONE" })
	hl(0, "CmpItemKindFile", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindFolder", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindColor", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindReference", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindOperator", { fg = b46.base05, bg = "NONE" })
	hl(0, "CmpItemKindTypeParameter", { fg = b46.red, bg = "NONE" })

	--
	-- ███╗░░░███╗██╗░░░██╗  ░█████╗░██╗░░░██╗░██████╗████████╗░█████╗░███╗░░░███╗
	-- ████╗░████║╚██╗░██╔╝  ██╔══██╗██║░░░██║██╔════╝╚══██╔══╝██╔══██╗████╗░████║
	-- ██╔████╔██║░╚████╔╝░  ██║░░╚═╝██║░░░██║╚█████╗░░░░██║░░░██║░░██║██╔████╔██║
	-- ██║╚██╔╝██║░░╚██╔╝░░  ██║░░██╗██║░░░██║░╚═══██╗░░░██║░░░██║░░██║██║╚██╔╝██║
	-- ██║░╚═╝░██║░░░██║░░░  ╚█████╔╝╚██████╔╝██████╔╝░░░██║░░░╚█████╔╝██║░╚═╝░██║
	-- ╚═╝░░░░░╚═╝░░░╚═╝░░░  ░╚════╝░░╚═════╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝
	--
	-- ██╗░░██╗██╗░██████╗░██╗░░██╗██╗░░░░░██╗░██████╗░██╗░░██╗████████╗░██████╗
	-- ██║░░██║██║██╔════╝░██║░░██║██║░░░░░██║██╔════╝░██║░░██║╚══██╔══╝██╔════╝
	-- ███████║██║██║░░██╗░███████║██║░░░░░██║██║░░██╗░███████║░░░██║░░░╚█████╗░
	-- ██╔══██║██║██║░░╚██╗██╔══██║██║░░░░░██║██║░░╚██╗██╔══██║░░░██║░░░░╚═══██╗
	-- ██║░░██║██║╚██████╔╝██║░░██║███████╗██║╚██████╔╝██║░░██║░░░██║░░░██████╔╝
	-- ╚═╝░░╚═╝╚═╝░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░
	--
	-- no lazy background
	hl(0, "LazyBackdrop", { bg = "NONE", force = true })
	-- costom rainbow-delimiters colors (base rose-pine with bumped up saturation)
	hl(0, "RainbowDelimiterYellow", { fg = mod.delimiters_yellow(), force = true })
	hl(0, "RainbowDelimiterRed", { fg = mod.delimiters_red(), force = true })
	hl(0, "RainbowDelimiterOrange", { fg = mod.delimiters_orange(), force = true })
	hl(0, "RainbowDelimiterBlue", { fg = mod.delimiters_teal(), force = true })
	hl(0, "RainbowDelimiterGreen", { fg = mod.delimiters_green(), force = true })
	hl(0, "RainbowDelimiterViolet", { fg = mod.delimiters_purple(), force = true })
	hl(0, "RainbowDelimiterCyan", { fg = mod.delimiters_cyan(), force = true })
	-- highlights for statusline that I wrote for old nvchad config that I lifted and modified to my needs
	-- my custom hls used in this statusline config:
	hl(0, "St_NormalMode_Root_Sep", { bg = "NONE", fg = mod.intense_pink(), bold = false })
	hl(0, "St_VisualMode_Root_Sep", { bg = "NONE", fg = mod.base_blue(), bold = false })
	hl(0, "St_InsertMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.purple_fg(), bold = false })
	hl(0, "St_ReplaceMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.yellow_warn(), bold = false })
	hl(0, "St_SelectMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.base_blue(), bold = false })
	hl(0, "St_CommandMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.green_fg(), bold = false })
	hl(0, "St_ConfirmMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.select_mode_teal(), bold = false })
	---@diagnostic disable-next-line: param-type-mismatch
	hl(0, "St_Root", { bg = mod.dark_base_bg(), fg = h.darken(mod.err_bg(), 0.2), bold = false })
	hl(0, "St_Root_Sep_Right", { bg = mod.path_bg(), fg = mod.dark_base_bg(), bold = false })
	hl(0, "St_NormalModeCustomTxt", { bg = mod.intense_pink(), fg = mod.base_bg(), bold = true })
	hl(0, "St_VisualModeCustomTxt", { bg = mod.base_blue(), fg = mod.base_bg(), bold = true })
	hl(0, "St_InsertModeCustomTxt", { bg = mod.purple_fg(), fg = mod.base_bg(), bold = true })
	hl(0, "St_ReplaceModeCustomTxt", { bg = mod.yellow_warn(), fg = mod.base_bg(), bold = true })
	hl(0, "St_SelectModeCustomTxt", { bg = mod.base_blue(), fg = mod.base_bg(), bold = true })
	hl(0, "St_CommandModeCustomTxt", { bg = mod.green_fg(), fg = mod.base_bg(), bold = true })
	hl(0, "St_ConfirmModeCustomTxt", { bg = mod.select_mode_teal(), fg = mod.base_bg(), bold = true })
	-- default hls used by nvchad extracted from that old config and injected into my config
	hl(0, "St_CommandMode", { bg = "NONE", bold = true, fg = mod.green_fg() })
	hl(0, "St_CommandModeCustomTxt", { bg = mod.green_fg(), bold = true, fg = mod.base_bg() })
	hl(0, "St_CommandModeSep", { bg = "NONE", bold = true, fg = mod.green_fg() })
	hl(0, "St_CommandMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.green_fg() })
	hl(0, "St_CommandmodeText", { bg = mod.path_bg(), bold = true, fg = mod.green_fg() })
	hl(0, "St_ConfirmMode", { bg = "NONE", bold = true, fg = mod.select_mode_teal() })
	hl(0, "St_ConfirmModeCustomTxt", { bg = mod.select_mode_teal(), bold = true, fg = mod.base_bg() })
	hl(0, "St_ConfirmModeSep", { bg = "NONE", bold = true, fg = mod.select_mode_teal() })
	hl(0, "St_ConfirmMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.select_mode_teal() })
	hl(0, "St_ConfirmmodeText", { bg = mod.path_bg(), bold = true, fg = mod.select_mode_teal() })
	hl(0, "St_EmptySpace", { fg = mod.base_bg() })
	hl(0, "St_EmptySpace2", { fg = mod.base_bg() })
	hl(0, "St_InsertMode", { bg = "NONE", bold = true, fg = mod.purple_fg() })
	hl(0, "St_InsertModeCustomTxt", { bg = mod.purple_fg(), bold = true, fg = mod.base_bg() })
	hl(0, "St_InsertModeSep", { bg = "NONE", bold = true, fg = mod.purple_fg() })
	hl(0, "St_InsertMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.purple_fg() })
	hl(0, "St_InsertmodeText", { bg = mod.path_bg(), bold = true, fg = mod.purple_fg() })
	hl(0, "St_LspHints", { fg = mod.purple_fg() })
	hl(0, "St_LspInfo", { fg = mod.green_fg() })
	hl(0, "St_LspProgress", { fg = mod.green_fg() })
	hl(0, "St_LspStatus_Icon", { bg = mod.base_blue(), fg = mod.base_bg() })
	hl(0, "St_NTerminalMode", { bg = "NONE", bold = true, fg = mod.intense_pink() })
	hl(0, "St_NTerminalModeCustomTxt", { bg = h.get_color("St_NTerminalMode", "fg"), bold = true, fg = mod.base_bg() })
	hl(0, "St_NTerminalModeSep", { bg = "NONE", bold = true, fg = mod.yellow_warn() })
	hl(0, "St_NTerminalMode_Root_Sep", { bg = "NONE", fg = mod.intense_pink() })
	hl(0, "St_NTerminalmodeText", { bg = mod.path_bg(), bold = true, fg = mod.yellow_warn() })
	hl(0, "St_NormalMode", { bg = "NONE", bold = true, fg = mod.intense_pink() })
	hl(0, "St_NormalModeCustomTxt", { bg = mod.intense_pink(), bold = true, fg = mod.base_bg() })
	hl(0, "St_NormalModeSep", { bg = "NONE", bold = true, fg = mod.base_blue() })
	hl(0, "St_NormalMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.intense_pink() })
	hl(0, "St_NormalmodeText", { bg = mod.path_bg(), fg = mod.intense_pink() })
	hl(0, "St_Pos_bg", { bg = mod.yellow_warn(), fg = mod.base_bg() })
	hl(0, "St_Pos_sep", { bg = "NONE", fg = mod.yellow_warn() })
	hl(0, "St_Pos_txt", { bg = mod.path_bg(), fg = mod.yellow_warn() })
	hl(0, "St_ReplaceMode", { bg = "NONE", bold = true, fg = mod.yellow_warn() })
	hl(0, "St_ReplaceModeCustomTxt", { bg = mod.yellow_warn(), bold = true, fg = mod.base_bg() })
	hl(0, "St_ReplaceModeSep", { bg = "NONE", bold = true, fg = mod.yellow_warn() })
	hl(0, "St_ReplaceMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.yellow_warn() })
	hl(0, "St_ReplacemodeText", { bg = mod.path_bg(), bold = true, fg = mod.yellow_warn() })
	hl(0, "St_SelectMode", { bg = "NONE", bold = true, fg = mod.base_blue() })
	hl(0, "St_SelectModeCustomTxt", { bg = mod.base_blue(), bold = true, fg = mod.base_bg() })
	hl(0, "St_SelectModeSep", { bg = "NONE", bold = true, fg = mod.base_blue() })
	hl(0, "St_SelectMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.base_blue() })
	hl(0, "St_SelectmodeText", { bg = mod.path_bg(), bold = true, fg = mod.base_blue() })
	hl(0, "St_TerminalMode", { bg = "NONE", bold = true, fg = mod.green_fg() })
	hl(0, "St_TerminalModeCustomTxt", { bg = mod.green_fg(), bold = true, fg = mod.base_bg() })
	hl(0, "St_TerminalModeSep", { bg = "NONE", bold = true, fg = mod.green_fg() })
	hl(0, "St_TerminalMode_Root_Sep", { bg = "NONE", fg = mod.green_fg() })
	hl(0, "St_TerminalmodeText", { bg = mod.path_bg(), bold = true, fg = mod.green_fg() })
	hl(0, "St_VisualMode", { bg = "NONE", bold = true, fg = mod.base_blue() })
	hl(0, "St_VisualModeCustomTxt", { bg = mod.base_blue(), bold = true, fg = mod.base_bg() })
	hl(0, "St_VisualModeSep", { bg = "NONE", bold = true, fg = mod.base_blue() })
	hl(0, "St_VisualMode_Root_Sep", { bg = mod.dark_base_bg(), fg = mod.base_blue() })
	hl(0, "St_VisualmodeText", { bg = mod.path_bg(), bold = true, fg = mod.base_blue() })
	hl(0, "St_cwd_bg", { bg = mod.yellow_warn(), fg = mod.base_bg() })
	hl(0, "St_cwd_sep", { bg = "NONE", fg = mod.yellow_warn() })
	hl(0, "St_cwd_txt", { bg = mod.path_bg(), fg = mod.yellow_warn() })
	hl(0, "St_file_bg", { bg = mod.err_bg(), fg = mod.base_bg() })
	hl(0, "St_file_info", { fg = mod.err_bg() })
	hl(0, "St_file_sep", { bg = "NONE", fg = mod.err_bg() })
	hl(0, "St_file_txt", { bg = mod.path_bg(), fg = mod.err_bg() })
	hl(0, "St_gitIcons", { bold = true, fg = mod.muted_light_bg() })
	hl(0, "St_lspError", { fg = b46.base08 })
	hl(0, "St_lspWarning", { fg = mod.yellow_warn() })
	hl(0, "St_lspHints", { fg = b46.purple })
	hl(0, "St_lsp_bg", { bg = mod.green_fg(), fg = mod.base_bg() })
	hl(0, "St_lsp_sep", { bg = "NONE", fg = mod.green_fg() })
	hl(0, "St_lsp_txt", { bg = mod.path_bg(), fg = mod.green_fg() })
	hl(0, "St_sep_r", { fg = mod.path_bg() })
	hl(0, "St_macro_sep", { fg = mod.path_bg(), bg = "none" })
	hl(0, "St_macro_reg", { bg = mod.path_bg(), fg = h.get_color("ErrorMsg", "fg") })
	hl(0, "St_AI_Disabled", { bg = h.get_color("Comment", "fg"), fg = mod.base_bg(), force = true })
	hl(0, "St_AI_Cmp_Enabled", { bg = h.get_color("Function", "fg"), fg = mod.base_bg(), force = true })
	hl(0, "St_AI_Chat_Enabled", { bg = h.get_color("Function", "fg"), fg = mod.base_bg(), force = true })

	-- snacks indentation guides
	hl(0, "SnacksIndent", { link = "VertSplit", force = true })
	hl(0, "SnacksIndentScope", { fg = mod.indent_lines(), force = true })
	hl(0, "MiniIndentscopeSymbol", { link = "SnacksIndentScope", force = true })
	--
	-- colorize gitignore to my liking because default theme does shit
	hl(0, "@string.special.path.gitignore", { link = "Normal", force = true })
	hl(0, "@punctuation.delimiter.gitignore", { link = "Added", force = true })
	hl(0, "@punctuation.bracket.gitignore", { link = "Added", force = true })
	hl(0, "@punctuation.special.gitignore", { link = "ErrorMsg", bold = true, force = true })
	hl(0, "@constant.gitignore", { link = "Function", force = true })
	hl(0, "@operator.gitignore", { link = "Function", force = true })
	hl(0, "@character.special.gitignore", { link = "Keyword", force = true })
	-- Improvements to linenr column
	hl(0, "InvisibleTxt", { fg = mod.base_bg(), bg = "NONE" })
	hl(0, "InvisibleBg", { bg = "NONE" })
	hl(0, "MyLineNrAbove", { fg = mod.line_nr_red(), bg = "NONE", force = true })
	hl(0, "MyLineNrBelow", { fg = mod.line_nr_teal(), bg = "NONE", force = true })
	hl(0, "LineNrAbove", { link = "MyLineNrAbove", force = true })
	hl(0, "LineNrBelow", { link = "MyLineNrBelow", force = true })
	-- recolor WinSeparator
	hl(0, "WinSeparator", { fg = mod.dark_base_bg(), bg = "none", force = true })
	-- blink
	hl(0, "BlinkCmpMenu", { bg = mod.low_dark_base_bg(), force = true })
	hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder", force = true })
	hl(0, "BlinkCmpDoc", { bg = mod.low_dark_base_bg(), force = true })
	hl(0, "BlinkCmpGhostText", { fg = mod.low_dark_base_bg(), force = true })
	hl(0, "BlinkCmpDocBorder", { fg = h.get_color("FloatBorder", "fg"), bg = mod.low_dark_base_bg(), force = true })
	---@diagnostic disable-next-line: param-type-mismatch
	hl(0, "Folded", { fg = h.muted_variant(mod.base_blue()), bg = h.muted_variant(mod.base_bg()), force = true })

	hl(0, "LspDiagnosticsVirtualTextError", { fg = b46.base08, bg = mod.diag_bg_error(), force = true })
	hl(0, "LspDiagnosticsVirtualTextWarning", { fg = b46.base09, bg = mod.diag_bg_warn(), force = true })
	hl(0, "LspDiagnosticsVirtualTextInformation", { fg = b46.sun, bg = mod.diag_bg_info(), force = true })
	hl(0, "LspDiagnosticsVirtualTextInfo", { fg = b46.sun, bg = mod.diag_bg_info(), force = true })
	hl(0, "LspDiagnosticsVirtualTextHint", { fg = b46.purple, bg = mod.diag_bg_hint(), force = true })
	hl(0, "DiagnosticVirtualTextError", { fg = b46.base08, bg = mod.diag_bg_error(), force = true })
	hl(0, "DiagnosticVirtualTextWarn", { fg = b46.base09, bg = mod.diag_bg_warn(), force = true })
	hl(0, "DiagnosticVirtualTextWarning", { fg = b46.base09, bg = mod.diag_bg_warn(), force = true })
	hl(0, "DiagnosticVirtualTextInformation", { fg = b46.sun, bg = mod.diag_bg_info(), force = true })
	hl(0, "DiagnosticVirtualTextInfo", { fg = b46.sun, bg = mod.diag_bg_info(), force = true })
	hl(0, "DiagnosticVirtualTextHint", { fg = b46.purple, bg = mod.diag_bg_hint(), force = true })
	--
	-- fzflua
	hl(0, "FzfLuaNormal", { fg = b46.white, bg = mod.low_dark_base_bg(), force = true })
	hl(0, "FzfLuaBorder", { fg = b46.base02, bg = mod.low_dark_base_bg(), force = true })
	hl(0, "FzfLuaTitle", { fg = b46.purple, bg = mod.low_dark_base_bg(), force = true })
	-- hl(0, "FzfLuaTitleFlags", { fg = b46.base05, bg = b46.base00 })
	hl(0, "FzfLuaBackdrop", { bg = mod.low_dark_base_bg(), force = true })
	hl(0, "FzfLuaPreviewBorder", { link = "FzfLuaBorder", force = true })
	hl(0, "FzfLuaPreviewNormal", { bg = mod.low_dark_base_bg(), force = true })
	hl(0, "FzfLuaCursorLine", { bg = b46.purple, force = true })
	-- hl(0, "FzfLuaCursorLineNr", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaSearch", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaScrollBorderEmpty", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaScrollBorderFull", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaScrollFloatEmpty", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaScrollFloatFull", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaHelpBorder", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaHeaderBind", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaHeaderText", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaPathColNr", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaPathLineNr", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaBufName", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaBufId", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaBufNr", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaBufLineNr", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaBufFlagCur", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaBufFlagAlt", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaTabTitle", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaTabMarker", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaDirIcon", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaDirPart", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaFilePart", { fg = b46.base05, bg = b46.base00 })
	hl(0, "FzfLuaLivePrompt", { fg = mod.delimiters_purple(), bg = "none" })
	-- hl(0, "FzfLuaLiveSym", { fg = b46.base05, bg = b46.base00 })
	hl(0, "FzfLuaFzfCursorLine", { bg = b46.base03, fg = mod.dark_base_bg(), force = true })
	-- hl(0, "FzfLuaFzfMatch", { fg = b46.base05, bg = b46.base00 })
	hl(0, "FzfLuaFzfBorder", { link = "FzfLuaBorder", force = true })
	hl(0, "FzfLuaFzfScrollbar", { link = "FzfLuaBorder", force = true })
	hl(0, "FzfLuaFzfSeparator", { link = "FzfLuaBorder", force = true })
	-- hl(0, "FzfLuaFzfGutter", { fg = b46.base05, bg = b46.base00 })
	hl(0, "FzfLuaFzfHeader", { fg = b46.purple, bg = mod.dark_base_bg(), force = true })
	hl(0, "FzfLuaFzfInfo", { fg = b46.purple, bg = mod.dark_base_bg(), force = true })
	hl(0, "FzfLuaFzfPointer", { fg = mod.delimiters_purple(), bg = "none" })
	-- hl(0, "FzfLuaFzfMarker", { fg = b46.base05, bg = b46.base00 })
	-- hl(0, "FzfLuaFzfSpinner", { fg = b46.base05, bg = b46.base00 })
	hl(0, "FzfLuaFzfPrompt", { fg = mod.delimiters_purple(), bg = "none" })
	-- hl(0, "FzfLuaFzfQuery", { fg = b46.base05, bg = b46.base00 })
end

return theme

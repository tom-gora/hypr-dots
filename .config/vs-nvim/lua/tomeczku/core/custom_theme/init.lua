-- theme variation lifted from NvChad's base46 selection as I like their colors better
-- than what official soho vibes provide
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞
--
local M = {}
local theme = require("tomeczku.core.custom_theme.theme")

M.setup = function()
	vim.cmd("hi clear")

	vim.o.background = "dark"
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.g.colors_name = "rosepine"

	theme.set_highlights()

	local groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"NvimFloat",
		"FloatNormal",
		"TemrinalNormal",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"EndOfBuffer",
		"TelescopePromptPrefix",
		"TelescopeNormal",
	}
	for _, v in ipairs(groups) do
		local ok, prev_attrs = pcall(vim.api.nvim_get_hl, 0, { name = v })
		---@diagnostic disable-next-line: undefined-field
		if ok and (prev_attrs.background or prev_attrs.bg or prev_attrs.ctermbg) then
			local attrs = vim.tbl_extend("force", prev_attrs, { bg = "NONE", ctermbg = "NONE" })
			attrs[true] = nil
			vim.api.nvim_set_hl(0, v, attrs)
		end
	end
end

return M
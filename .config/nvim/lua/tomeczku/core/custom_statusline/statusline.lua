-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞

local M = {}

---@param modules table
local function compose_modules(modules)
	-- import component functions
	local c = require("tomeczku.core.custom_statusline.components")
	-- assign the components
	table.insert(modules, c.mode_plus_path())
	table.insert(modules, c.macro_indicator())
	table.insert(modules, c.git())
	table.insert(modules, "%=")
	table.insert(modules, c.ai_status())
	-- wordcounter for markdown files only
	if vim.b.markdown == true then
		table.insert(modules, c.markdown_wordcounter())
	end
	table.insert(modules, c.lsp_status())
	table.insert(modules, c.lsp_diags())
	table.insert(modules, c.cursor_pos())
end

-- return by calling a function explicitely mainly to ensure vim.g.statusline_winid gets set
-- because this was a bitch of troubleshooting to fix -_-

---@return string
M.compose_statusline = function()
	local modules = {}
	compose_modules(modules)
	return table.concat(modules)
end

return M

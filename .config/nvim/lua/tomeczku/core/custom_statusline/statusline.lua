-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞

local M = {}

---@param modules table
local function compose_modules(modules)
	-- import component functions
	local c = require("tomeczku.core.custom_statusline.components")
	-- assign the components
	modules[1] = c.mode_plus_path()
	modules[2] = c.macro_indicator()
	modules[3] = c.git()
	modules[4] = "%="
	modules[5] = c.ai_status()
	modules[6] = c.lsp_stat()
	modules[7] = c.lsp_diags()
	modules[8] = c.cursor_pos()
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

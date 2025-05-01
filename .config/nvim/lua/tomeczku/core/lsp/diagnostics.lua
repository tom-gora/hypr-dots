local M, s = {}, vim.diagnostic.severity

local icons = {
	[s.ERROR] = "",
	[s.INFO] = "",
	[s.WARN] = "",
	[s.HINT] = "",
}

---@param diag vim.Diagnostic
---@return string
local setDiagnosticsFormat = function(diag)
	if not string.match(diag.source:sub(-1), "[A-Za-z0-9]") then
		diag.source = diag.source:sub(1, #diag.source - 1)
	end
	return icons[diag.severity] .. "  " .. diag.source .. ":  " .. diag.message .. "   "
end

M.setup = function()
	vim.diagnostic.config({
		underline = { severity = s.WARN },
		virtual_text = {
			prefix = "",
			suffix = function()
				local lnum = vim.fn.getcurpos()[2] - 1
				local count = #vim.diagnostic.get(0, { lnum = lnum })
				if count <= 1 then
					return ""
				else
					return "[" .. tostring(count) .. "]"
				end
			end,
			current_line = true,
			format = setDiagnosticsFormat,
			virt_text_pos = "eol_right_align",
			hl_mode = "combine",
			severity = s.WARN,
		},
		virtual_lines = false,
		signs = {
			priority = 100,
			text = {
				[s.ERROR] = icons[s.ERROR],
				[s.WARN] = icons[s.WARN],
				[s.INFO] = icons[s.INFO],
				[s.HINT] = icons[s.HINT],
			},
		},
		float = {
			header = "",
			format = setDiagnosticsFormat,
			severity_sort = true,
		},
	})
	require("tomeczku.core.keymaps.helpers").setDiagnosticsMappings()
end

return M

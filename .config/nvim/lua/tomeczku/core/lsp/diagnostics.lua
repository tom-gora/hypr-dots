local M, s, h = {}, vim.diagnostic.severity, require("tomeczku.core.keymaps.helpers")

local icons = {
	[s.ERROR] = "",
	[s.INFO] = "",
	[s.WARN] = "",
	[s.HINT] = "󰛩",
}

local setDiagnosticsFormatLine = function(diag)
	if not string.match(diag.source:sub(-1), "[A-Za-z0-9]") then
		diag.source = diag.source:sub(1, #diag.source - 1)
	end
	return "  <--  " .. icons[diag.severity] .. " " .. diag.source .. ":  " .. diag.message .. "  "
end

local setDiagnosticsFormatFloat = function(diag)
	if not string.match(diag.source:sub(-1), "[A-Za-z0-9]") then
		diag.source = diag.source:sub(1, #diag.source - 1)
	end
	return " " .. icons[diag.severity] .. " " .. diag.source .. ":  " .. diag.message .. "  "
end

M.setup = function()
	vim.diagnostic.config({
		virtual_text = {
			format = setDiagnosticsFormatLine,
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
			format = setDiagnosticsFormatFloat,
			severity_sort = true,
		},
	})
	h.setDiagnosticsMappings()
end

return M

local M, h = {}, require("tomeczku.core.keymaps.helpers")

local setDiagnosticsFormatLine = function(diag)
	if not string.match(diag.source:sub(-1), "[A-Za-z0-9]") then
		diag.source = diag.source:sub(1, #diag.source - 1)
	end
	if diag.severity == vim.diagnostic.severity.ERROR then
		return "  <--    " .. diag.source .. ":  " .. diag.message .. "  "
	elseif diag.severity == vim.diagnostic.severity.WARN then
		return "  <--    " .. diag.source .. ": " .. diag.message .. "  "
	elseif diag.severity == vim.diagnostic.severity.INFO then
		return "  <--    " .. diag.source .. ":  " .. diag.message .. "  "
	elseif diag.severity == vim.diagnostic.severity.HINT then
		return "  <--    " .. diag.source .. ":  " .. diag.message .. "  "
	end
end

local setDiagnosticsFormatFloat = function(diag)
	if not string.match(diag.source:sub(-1), "[A-Za-z0-9]") then
		diag.source = diag.source:sub(1, #diag.source - 1)
	end
	if diag.severity == vim.diagnostic.severity.ERROR then
		return "   " .. diag.source .. ":  " .. diag.message .. "  "
	elseif diag.severity == vim.diagnostic.severity.WARN then
		return "   " .. diag.source .. ": " .. diag.message .. "  "
	elseif diag.severity == vim.diagnostic.severity.INFO then
		return "   " .. diag.source .. ":  " .. diag.message .. "  "
	elseif diag.severity == vim.diagnostic.severity.HINT then
		return "   " .. diag.source .. ":  " .. diag.message .. "  "
	end
end

M.setup = function()
	vim.diagnostic.config({
		virtual_text = {
			format = setDiagnosticsFormatLine,
			virt_text_pos = "eol_right_align",
			hl_mode = "combine",
		},
		virtual_lines = false,
		float = {
			header = "",
			format = setDiagnosticsFormatFloat,
			severity_sort = true,
		},
	})
	h.setDiagnosticsMappings()
end

return M

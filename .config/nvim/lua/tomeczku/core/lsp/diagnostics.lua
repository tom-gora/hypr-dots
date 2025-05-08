local M, s = {}, vim.diagnostic.severity

local icons = {
	[s.ERROR] = "",
	[s.INFO] = "",
	[s.WARN] = "",
	[s.HINT] = "",
}
---@diagnostic disable-next-line: type-not-found
---@param diag vim.Diagnostic
---@return string
local setDiagnosticsFormat = function(diag)
	local src = "LSP"
	if diag.source or diag.source ~= nil then
		src = diag.source
	end
	if src and not string.match(src:sub(-1), "[A-Za-z0-9]") then
		src = src:sub(1, #src - 1)
	end
	return icons[diag.severity] .. "  " .. src .. ": " .. diag.message .. " "
end

local diag_opts = {
	underline = { severity = s.WARN },
	severity_sort = true,
	virtual_text = {
		prefix = "",
		suffix = function()
			local lnum = vim.fn.getcurpos()[2] - 1
			---@diagnostic disable-next-line: param-type-not-match
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
		-- severity = { s.WARN, s.ERROR },
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
}

M.setup = function()
	vim.diagnostic.config(diag_opts)
	require("tomeczku.core.keymaps.helpers").setDiagnosticsMappings()
end

return M

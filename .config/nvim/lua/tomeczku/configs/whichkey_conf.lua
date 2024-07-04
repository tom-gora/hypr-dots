local M = {}

M.opts = {
	window = { border = "rounded" },
	layout = {
		height = { min = 3, max = 25 },
		width = { min = 20, max = 30 },
		spacing = 3,
		align = "center",
	},
	icons = {
		separator = "",
		group = "»  ",
	},
}

M.init_function = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 250
	end


M.config_function = function(_, opts)
  local wk = require("which-key")
	wk.setup(opts)
end

return M

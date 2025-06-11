local M

M = {
	"shellRaining/hlchunk.nvim",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({

			chunk = { enable = false },
			indent = {
				enable = true,
				style = {
					{ fg = "#806d9c" }, -- will translate to HLIndent1
					{ link = "SnacksIndent" },
					{ link = "SnacksIndent" },
					{ link = "SnacksIndent" },
					{ link = "SnacksIndent" },
					{ link = "SnacksIndent" },
				},
			},
			line_num = { enable = false },
			blank = {
				enable = false,
			},
		})
	end,
}

return M

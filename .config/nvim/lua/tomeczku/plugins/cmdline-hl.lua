-- finally something simple replacing noice!
local M, opts

opts = {
	type_signs = {
		[":"] = { "  ", "Title" },
		["/"] = { "  󰅀", "Boolean" },
		["?"] = { "  󰅃", "Boolean" },
		["="] = { "  ", "String" },
	},
	custom_types = {
		["!"] = { lang = "bash", icon = "  ", icon_hl = "RainbowDelimiterRed", show_cmd = false },
		["help"] = { icon = " 󰞋 ", show_cmd = false },
		["lua"] = { lang = "lua", icon = " 󰢱 ", icon_hl = "RainbowDelimiterBlue", show_cmd = false },
		["substitute"] = {
			pat = "%w(.*)",
			lang = "regex",
			icon = "  ",
			icon_hl = "RainbowDelimiterOrange",
			show_cmd = true,
		},
	},
	ghost_text = false,
}

M = {
	{
		"Sam-programs/cmdline-hl.nvim",
		enabled = true,
		event = "VimEnter",
		config = function()
			require("cmdline-hl").setup(opts)
		end,
	},
}

return M

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
}

M = {
	{
		"Sam-programs/cmdline-hl.nvim",
		event = "VimEnter",
		opts = opts,
	},
}

return M

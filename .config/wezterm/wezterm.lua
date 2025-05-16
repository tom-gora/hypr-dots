local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_decorations = "NONE"
config.color_scheme = "Rosé Pine Moon (Gogh)"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = 600 })
config.font_size = 11
config.line_height = 1.1

config.window_padding = {
	left = 4,
	right = 4,
	top = 2,
	bottom = 0,
}

config.colors = { background = "#191724" }
config.font_rules = {
	{
		italic = true,
		font = wezterm.font("Operator Mono", { style = "Italic" }),
	},
	-- fallback
	{
		italic = true,
		intensity = "Half",
		font = wezterm.font("JetBrainsMono Nerd Font"),
	},
}

config.window_close_confirmation = "NeverPrompt"
config.default_prog = { "/usr/bin/zsh" }
config.keys = {
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			pane:send_text("clear\r") -- CTRL-L substitute since this is used for tmux-navigator
		end),
	},
}

return config

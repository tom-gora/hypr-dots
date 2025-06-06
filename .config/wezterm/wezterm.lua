local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_decorations = "NONE"
config.color_scheme = "Rosé Pine Moon (Gogh)"
config.font = wezterm.font({
	family = "0xProto Nerd Font",
	weight = "Bold",
	harfbuzz_features = { "zero", "ss01", "cv05" },
})
config.font_size = 11
config.line_height = 1.1

config.window_padding = {
	left = 2,
	right = 0,
	top = 4,
	bottom = 0,
}

config.colors = { background = "#191724" }
config.font_rules = {
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font("0xProto Nerd Font", { style = "Italic", weight = "Regular" }),
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
	-- {
	-- 	key = "l",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = wezterm.action_callback(function(_, pane)
	-- 		pane:send_text("clear\r") -- CTRL-L substitute since this is used for tmux-navigator
	-- 	end),
	-- },
}

return config

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_background_opacity = 0.92
config.color_scheme = "Rosé Pine Moon (base16)"
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
config.disable_default_key_bindings = true

return config

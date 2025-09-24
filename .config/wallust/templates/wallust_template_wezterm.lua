return {
	foreground = "{{foreground}}",
	background = "{{background | darken(0.9)}}",

	cursor_bg = "{{cursor | saturate(0.2) | lighten(0.5)}}",
	cursor_fg = "{{ background | saturate(0.2) | darken(0.9) | blend("#000000")}}",
	cursor_border = "{{cursor | saturate(0.2) | lighten(0.5) }}",

	selection_fg = "{{foreground}}",
	selection_bg = "{{cursor}}",

	scrollbar_thumb = "{{cursor}}",

	split = "{{cursor}}",

	ansi = {
		"{{background | darken(0.9)}}",
		"{{color1}}",
		"{{color2}}",
		"{{color3}}",
		"{{color4}}",
		"{{color5}}",
		"{{color6}}",
		"{{color7}}",
	},
	brights = {
		"{{color8}}",
		"{{color9}}",
		"{{color10}}",
		"{{color11}}",
		"{{color12}}",
		"{{color13}}",
		"{{color14}}",
		"{{color15}}",
	},
}

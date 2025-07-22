local hsl = require("tomeczku.core.theme.hsl")

local PALETTE = {
	black = {
		darker = hsl(248, 22, 3),
		dark = hsl(248, 22, 9),
		base = hsl(248, 22, 12),
		light = hsl(248, 22, 15),
		lighter = hsl(248, 22, 18),
		muted_base = hsl(248, 12, 37),
		muted_dark = hsl(248, 12, 27),
		muted_darker = hsl(248, 12, 17),
	},
	white = {
		base = hsl(245, 50, 91),
		dark = hsl(245, 22, 71),
		darker = hsl(245, 12, 51),
	},
	red = {
		base = hsl(343, 76, 68),
		light = hsl(343, 76, 82),
		intense = hsl(343, 95, 68),
		oversaturated = hsl(343, 62, 53),
		muted = hsl(343, 32, 42),
		tinted_bg = hsl(278, 21, 4),
	},
	pink = {
		base = hsl(2, 66, 75),
		light = hsl(2, 55, 85),
		intense = hsl(2, 80, 75),
		oversaturated = hsl(2, 82, 65),
		muted = hsl(2, 20, 50),
	},
	blue = {
		base = hsl(189, 43, 73),
		light = hsl(189, 43, 83),
		intense = hsl(189, 53, 63),
		muted = hsl(189, 32, 42),
		oversaturated = hsl(189, 68, 53),
		tinted_bg = hsl(232, 21, 4),
	},
	green = {
		base = hsl(125, 73, 83),
		light = hsl(125, 43, 93),
		intense = hsl(125, 78, 78),
		muted = hsl(125, 20, 37),
		oversaturated = hsl(125, 93, 73),
		tinted_bg = hsl(225, 21, 4),
	},
	cyan = {
		base = hsl(197, 48, 47),
		light = hsl(197, 48, 70),
		intense = hsl(197, 49, 37),
		oversaturated = hsl(197, 92, 35),
		muted = hsl(197, 20, 50),
	},
	yellow = {
		base = hsl(35, 88, 72),
		light = hsl(34, 88, 86),
		intense = hsl(35, 88, 65),
		muted = hsl(34, 20, 52),
		oversaturated = hsl(35, 92, 55),
		tinted_bg = hsl(275, 21, 4),
	},
	purple = {
		base = hsl(267, 57, 78),
		light = hsl(267, 57, 86),
		intense = hsl(267, 42, 66),
		muted = hsl(267, 20, 37),
		oversaturated = hsl(267, 52, 52),
		tinted_bg = hsl(251, 21, 4),
	},
}

return PALETTE

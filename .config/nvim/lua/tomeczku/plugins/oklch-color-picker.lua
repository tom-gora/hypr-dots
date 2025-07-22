if vim.g.vscode then
	return
end

local M, opts

opts = {
	highlight = {
		style = "foreground+virtual_eol",
		bold = false,
		virtual_text = "",
		enabled_lsps = { "tailwindcss", "tailwindcss-language-server", "css-lsp", "css-variables-language-server" },
		emphasis = {
			-- Distance (0..1) to the editor background where emphasis activates (first item for dark themes, second for light ones).
			threshold = { 0.2, 0.17 },
			-- How much (0..255) to offset the color (first item for dark colors, second for light ones).
			amount = { 15, -80 },
		},
	},
	patterns = {
		lua_hsl = {
			priority = 20,
			ft = { "lua" },
			custom_parse = function(matched_string)
				local h, s, l = string.match(matched_string, "hsl%((%d+%.?%d*),%s*(%d+%.?%d*),%s*(%d+%.?%d*)%)")

				local function hsl_to_rgb(h_val, s_val, l_val)
					h_val = h_val / 360
					s_val = s_val / 100
					l_val = l_val / 100
					local r, g, b
					if s_val == 0 then
						r, g, b = l_val, l_val, l_val
					else
						local hue2rgb = function(p, q, t)
							if t < 0 then
								t = t + 1
							end
							if t > 1 then
								t = t - 1
							end
							if t < 1 / 6 then
								return p + (q - p) * 6 * t
							end
							if t < 1 / 2 then
								return q
							end
							if t < 2 / 3 then
								return p + (q - p) * (2 / 3 - t) * 6
							end
							return p
						end
						local q = l_val < 0.5 and l_val * (1 + s_val) or l_val + s_val - l_val * s_val
						local p = 2 * l_val - q
						r = hue2rgb(p, q, h_val + 1 / 3)
						g = hue2rgb(p, q, h_val)
						b = hue2rgb(p, q, h_val - 1 / 3)
					end
					return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
				end

				local r, g, b = hsl_to_rgb(tonumber(h), tonumber(s), tonumber(l))
				return (r * 65536) + (g * 256) + b
			end,
			"()hsl%((%d+%.?%d*),%s*(%d+%.?%d*),%s*(%d+%.?%d*)%)()",
		},
	},
}

M = {
	"eero-lehtinen/oklch-color-picker.nvim",
	event = "VeryLazy",
	version = "*",
	keys = {
		{
			"<leader>fc",
			function()
				require("oklch-color-picker").pick_under_cursor()
			end,
			desc = "Color pick under cursor",
		},
	},
	opts = opts,
}

return M

local M = {}

M = {
	filetypes = {
		"*", -- Highlight all files, but customize some others.
		"!vim", -- Exclude vim from highlighting.
		"!txt",
		-- Exclusion Only makes sense if '*' is specified!
	},
	user_default_options = {
		css = true,
		tailwind = true,
		mode = "background",
	},
}

return M

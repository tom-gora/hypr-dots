-- correctly identify less common filetypes
vim.filetype.add({
	pattern = {
		[".*/*.rasi"] = "rasi",
	},
})

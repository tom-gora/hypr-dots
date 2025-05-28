vim.b.checkhealth = true

local width = math.max(math.floor(vim.o.columns * 0.85), 60)
local height = math.max(math.floor(vim.o.lines * 0.75), 20)

local col = math.floor((vim.o.columns - width) / 2)

vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
	border = "solid",
	title_pos = "right",
	title = "  Checkhealth ",
	width = width,
	height = height,
	relative = "editor",
	row = 2,
	col = col,
})

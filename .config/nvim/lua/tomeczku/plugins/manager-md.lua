local M

M = {
	dir = "/home/tomeczku/Programming/nvim_plugins_workshop/manager-md.nvim/",
	config = function()
		local m = require("manager-md")
		m.setup({
			-- "right-split" | "bottom-split" | "center-float" | "right-float"
			position = "right-split",
			window = {
				border = "solid",
			},
			-- arbitrary function to modify ui or behavior to your liking.
			-- takes 2 params win and buf
			on_open = function(win, _)
				vim.api.nvim_win_set_var(win, "skip_bg_change", true)
				vim.api.nvim_win_set_option(win, "winhighlight", "Normal:NormalFloat")
			end,
			project_name = "dir",
		})
	end,
}
-- M = {
-- 	dir = "/home/tomeczku/Programming/nvim_plugins_workshop/layout-testing.nvim/",
-- 	config = function()
-- 		require("layout-testing").setup({
-- 			position = "float",
-- 		})
-- 	end,
-- }

return M

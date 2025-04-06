local M, map, ignore = {}, vim.keymap.set, { desc = "which_key_ignore" }

-- proxy <c-w> to <leader>v through whichkey
M.proxySplitsGroup = function()
	local wk = require("which-key")
	wk.add({
		{ "<leader>v", proxy = "<c-w>", group = " Splits" },
		{
			mode = { "x" },
			{ "<leader>ri", group = "Replace Inside Visual Selection" },
			{ "<leader>~", group = "󰬴 TextCase" },
		},
	})
end

M.setupCmdlineAndWildmenu = function()
	-- HACK: This worked! with arcane vimscript! XD Dunno why but I'll take it
	vim.cmd([[
    cmap <C-j> <C-n>
    cmap <C-k> <C-p>
    cmap <C-a> <C-y>
  ]])
end

M.nonDestructivePaste = function()
	map("x", "p", "P", ignore)
end

return M

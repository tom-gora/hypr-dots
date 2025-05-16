local M, map, h = {}, vim.keymap.set, require("tomeczku.core.keymaps.helpers")

-- proxy <c-w> to <leader>v through whichkey
M.wkProxies = function()
	local ok, wk = pcall(require, "which-key")
	if not ok then
		return
	end
	wk.add({
		{ "<leader>v", proxy = "<c-w>", group = " Splits" },
		{ "<leader>s", proxy = "z=", desc = "󰓆 Spell Suggestions" },
		{
			mode = { "x" },
			{ "<leader>ri", group = "Replace Inside Visual Selection" },
			{ "<leader>~", group = "󰬴 TextCase" },
		},
	})
end

M.setupCmdlineAndWildmenu = function()
	-- HACK: This worked! with vimscript! XD Dunno why but I'll take it
	vim.cmd([[
    cmap <C-j> <C-n>
    cmap <C-k> <C-p>
    cmap <C-a> <C-y>
  ]])
end

M.nonDestructivePaste = function()
	map("x", "p", "P", h.setOpts({ desc = "ignore" }))
end

M.disableDefaults = function()
	local modes = { "n", "i", "x" }
	local keys = { "<Up>", "<Down>", "<Left>", "<Right>", "<F1>" }

	for _, mode in ipairs(modes) do
		for _, key in ipairs(keys) do
			map(mode, key, "<Nop>", h.setOpts())
		end
	end
end

return M

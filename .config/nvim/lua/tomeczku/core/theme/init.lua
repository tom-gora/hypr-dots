local M, theme = {}, require("tomeczku.core.theme.theme")

M.setup = function(theme_name)
	vim.cmd("hi clear")
	vim.o.background = "dark"
	vim.cmd("syntax reset")

	vim.o.termguicolors = true
	vim.g.colors_name = theme_name

	theme.setup(theme_name)

	local groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		-- "NvimFloat",
		-- "FloatNormal",
		"TemrinalNormal",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"EndOfBuffer",
	}
	for _, v in ipairs(groups) do
		local ok, prev_attrs = pcall(vim.api.nvim_get_hl, 0, { name = v })
		if ok and (prev_attrs.bg or prev_attrs.ctermbg) then
			local attrs = vim.tbl_extend("force", prev_attrs, { bg = "NONE", ctermbg = "NONE" })
			attrs[true] = nil
			vim.api.nvim_set_hl(0, v, attrs)
		end
	end

	if _G.is_theme_gen and _G.is_theme_gen == true then
		local watcher = function()
			local watched_path = os.getenv("HOME") .. "/.cache/wallust/targets/nvim.lua"
			reload_event = vim.uv.new_fs_event()
			reload_event:start(watched_path, {
				watch_entry = true,
				start = true,
			}, function(_)
				package.loaded["tomeczku.core.theme"] = nil
				package.loaded["tomeczku.core.theme.theme"] = nil
				package.loaded["tomeczku.core.theme.palettes.wallust"] = nil
				vim.schedule(function()
					dofile(vim.fn.stdpath("config") .. "/lua/tomeczku/core/init.lua")
				end)
			end)
		end

		watcher()
	end
end

return M

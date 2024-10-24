--[[
 _       ___    _____
| |     / (_)__/__  /  ____ _____
| | /| / / / __ \/ /  / __ `/ __ \
| |/ |/ / / / / / /__/ /_/ / /_/ /
|__/|__/_/_/ /_/____/\__,_/ .___/
                         /_/
--]]
--
-- INFO: Init the base state on startup
--
_G.WinZapState = {
	wz_is_splits = false,
	wz_splits_count = 1,
}

local fn = vim.fn
local map = vim.keymap.set
local map_opts = { desc = "which_key_ignore", noremap = true, silent = true }

require("tomeczku.core.winZap.wz_state_machine")
local wz_handlers = require("tomeczku.core.winZap.wz_action_handlers")

local wz_handle_split_jump = function(direction)
	local state = _G.WinZapState
	-- PERF: If just single editor window, no splits and no floats then just return and do nothing
	if not state.wz_is_splits and not state.wz_is_any_floating then
		return
	end

	-- if no floats but regular splits present just execute normal navigation then early return
	if state.wz_is_splits == true then
		wz_handlers.wz_handle_split_jump(direction, state, fn.winnr())
		return
	end
end

map("n", "<C-h>", function()
	wz_handle_split_jump("l")
end, map_opts)
map("n", "<C-l>", function()
	wz_handle_split_jump("r")
end, map_opts)
map("n", "<C-j>", function()
	wz_handle_split_jump("d")
end, map_opts)
map("n", "<C-k>", function()
	wz_handle_split_jump("u")
end, map_opts)

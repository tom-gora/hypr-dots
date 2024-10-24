--[[
 _       ___    _____
| |     / (_)__/__  /  ____ _____
| | /| / / / __ \/ /  / __ `/ __ \
| |/ |/ / / / / / /__/ /_/ / /_/ /
|__/|__/_/_/ /_/____/\__,_/ .___/
                         /_/
--]]
--
-- INFO: Return handler functions for specific movement scanarios based on state
--
local M = {}
local fn = vim.fn
local cmd = vim.cmd
local noti_ok, noti = pcall(require, "notify")

local valid_directions = {
	l = true,
	r = true,
	d = true,
	u = true,
}

-- handlers blow:
local invalid_direction_notify = function()
	if noti_ok then
		local noti_opts = { title = "WinZap", icon = "󰑮 ", timeout = 500, hide_from_history = true }
		noti("Error: Invalid direction passsed! [WinZap]", "error", noti_opts)
	else
		vim.notify("Error: Invalid direction passsed! [WinZap]", vim.log.levels.ERROR)
	end
end

M.wz_handle_split_jump = function(direction, s, wnr)
	if not valid_directions[direction] then
		invalid_direction_notify()
		return
	end

	-- Double check: if no splits ignore
	if s.wz_is_splits == false then
		return
	end
	if direction == "l" then
		-- move to left split
		cmd("wincmd h")
		-- PERF: inspired by solution found online where cycling back is done via just executing
		-- move in the oposite direction some arbitrary large amount of times like "wincmd 200h"
		-- LIMITATION: with available win properties I cannot reliably track size of the windows stack
		-- in h/v directions so the compromise is to track and store in state total count of splits
		-- and move the focus by this count + 1 for good measure.
		-- it's always better than just spamming runtime with 200 actions and it works reliable enough

		-- if after move win stayed the same cycle to right
		if wnr == fn.winnr() then
			cmd("wincmd " .. s.wz_splits_count + 1 .. "l")
			return
		end
		return
	elseif direction == "r" then
		-- move to right split
		cmd("wincmd l")
		-- if after move win stayed the same cycle to left
		if wnr == fn.winnr() then
			cmd("wincmd " .. s.wz_splits_count + 1 .. "h")
			return
		end
		return
	elseif direction == "u" then
		-- move to upper split
		cmd("wincmd k")
		-- if after move win stayed the same cycle to bottom
		if wnr == fn.winnr() then
			cmd("wincmd " .. s.wz_splits_count + 1 .. "j")
			return
		end
		return
	elseif direction == "d" then
		-- move to lower split
		cmd("wincmd j")
		-- if after move win stayed the same cycle to top
		if wnr == fn.winnr() then
			cmd("wincmd " .. s.wz_splits_count + 1 .. "k")
			-- fn.win_gotoid(sState.wz_bottom_split)
			return
		end
		return
	end
end

return M

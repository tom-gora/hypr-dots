--[[
 _       ___    _____
| |     / (_)__/__  /  ____ _____
| | /| / / / __ \/ /  / __ `/ __ \
| |/ |/ / / / / / /__/ /_/ / /_/ /
|__/|__/_/_/ /_/____/\__,_/ .___/
                         /_/
--]]

--
-- INFO:
-- LOGIC TO ADJUST GLOBALLY ACCESSIBLE LAYOUT STATE USING AUTOCOMMANDS FOR TRACKING
-- AND PROVIDING CONDITIONS TO DECIDE MOVEMENT HANDLING
--

local api = vim.api
local fn = vim.fn
-- grouop for autocommads
local WzGroup = vim.api.nvim_create_augroup("WinZap", { clear = true })

-- preconfigure filetypes that should be skipped and not trigger the change of layout state
local excluded_filetypes = {
	notify = true,
	cmp_docs = true,
	cmp_menu = true,
}

-- ---------------- --
--                  --
-- A U T O C M D S  --
--                  --
-- ---------------- --
api.nvim_create_autocmd({ "WinNew", "WinClosed" }, {
	group = WzGroup,
	callback = function()
		vim.schedule(function()
			local state = _G.WinZapState
			-- reset state ahead of iteration
			state.wz_splits_count = 1
			state.wz_is_splits = false
			-- PERF: don't trigger state change with irrelevant popups and such
			-- TODO: excluded_filetypes could be a config table
			if excluded_filetypes[vim.bo.filetype] then
				return
			end
			-- also if win not focusable
			if not api.nvim_win_get_config(0).focusable then
				return
			end

			-- iterate over visible windows and adjust the state where relevant
			for _, id in pairs(api.nvim_tabpage_list_wins(0)) do
				local c = api.nvim_win_get_config(id)
				local t = fn.win_gettype(id)
				--
				if
					not c.zindex
					and c.focusable
					and not c.anchor
					and not c.hide
					and not c.footer
					and not c.style
					and c.relative == ""
					and c.split ~= "left"
				then
					state.wz_splits_count = state.wz_splits_count + 1
					state.wz_is_splits = true
				end
			end
		end)
	end,
})

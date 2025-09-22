local M = {}

_G.theme_reload_event = nil
-- lock value to stagger executions and not allow race conditions and conflicts and shit
M.is_reloading = false

local unlock = function()
	M.is_reloading = false
end

local exec_reload = function()
	package.loaded["tomeczku.core.theme"] = nil
	package.loaded["tomeczku.core.theme.palettes.wallust"] = nil
	package.loaded["tomeczku.core.theme.generated_theme_reloader"] = nil

	dofile(vim.fn.stdpath("config") .. "/lua/tomeczku/core/theme/generated_theme_reloader.lua")
	require("todo-comments").reset()
	require("oklch-color-picker.highlight").toggle()
	require("oklch-color-picker.highlight").toggle()
	vim.defer_fn(unlock, 500)
end

M.setup = function()
	if _G.is_theme_gen and _G.is_theme_gen == true then
		local watched_path = os.getenv("HOME") .. "/.cache/wallust/targets/nvim.lua"

		local f = io.open(watched_path, "r")
		if not f then
			vim.notify("Theme file not found: " .. watched_path, vim.log.levels.WARN)
			return
		end
		f:close()

		-- I mean.. just in check. Not going to old versions but...
		if vim.uv then
			_G.theme_reload_event = vim.uv.new_fs_event()
		else
			_G.theme_reload_event = vim.loop.new_fs_event()
		end

		-- Start watching the file
		_G.theme_reload_event:start(watched_path, {
			watch_entry = true,
			stat = true,
		}, function(err, _, _)
			if err then
				vim.notify("Error watching theme file: " .. err, vim.log.levels.ERROR)
				return
			end

			-- have we put competing calls on stack??? ;>
			---@diagnostic disable-next-line: unnecessary-if
			if M.is_reloading then
				return
			end

			-- put the lock on if it's a go
			M.is_reloading = true

			vim.schedule(function()
				-- wrap in extra staggered defer to wait for wallust to finish writes
				-- because apparently sometimes complex rust it's not catching up with straightforward luajit ;)
				vim.defer_fn(exec_reload, 300)
			end)
		end)
	end
end

return M

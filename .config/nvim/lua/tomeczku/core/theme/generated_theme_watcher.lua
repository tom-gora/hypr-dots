local M = {}

_G.theme_reload_event = nil
M.is_reloading = false

M.setup = function()
	if _G.is_theme_gen and _G.is_theme_gen == true then
		local watched_path = os.getenv("HOME") .. "/.cache/wallust/targets/nvim.lua"

		local f = io.open(watched_path, "r")
		if not f then
			vim.notify("Theme file not found: " .. watched_path, vim.log.levels.WARN)
			return
		end
		f:close()

		if vim.uv then
			_G.theme_reload_event = vim.uv.new_fs_event()
		else
			_G.theme_reload_event = vim.loop.new_fs_event()
		end

		-- Debug notification
		vim.notify("Theme watcher initialized for: " .. watched_path)

		-- Start watching the file
		_G.theme_reload_event:start(watched_path, {
			watch_entry = true,
			stat = true,
		}, function(err, _, _)
			if err then
				vim.notify("Error watching theme file: " .. err, vim.log.levels.ERROR)
				return
			end

			---@diagnostic disable-next-line: unnecessary-if
			if M.is_reloading then
				return
			end

			M.is_reloading = true

			vim.schedule(function()
				package.loaded["tomeczku.core.theme"] = nil
				package.loaded["tomeczku.core.theme.palettes.wallust"] = nil
				package.loaded["tomeczku.core.theme.generated_theme_reloader"] = nil

				dofile(vim.fn.stdpath("config") .. "/lua/tomeczku/core/theme/generated_theme_reloader.lua")
				require("todo-comments").reset()
				require("oklch-color-picker.highlight").toggle()
				require("oklch-color-picker.highlight").toggle()

				vim.defer_fn(function()
					M.is_reloading = false
				end, 500)
			end)
		end)
	end
end

return M

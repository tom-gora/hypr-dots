local M = {}

M.setup = function()
	if _G.is_theme_gen and _G.is_theme_gen == true then
		local watcher = function()
			local watched_path = os.getenv("HOME") .. "/.cache/wallust/targets/nvim.lua"
			reload_event = vim.uv.new_fs_event()
			reload_event:start(watched_path, {
				watch_entry = true,
				start = true,
			}, function(_)
				package.loaded["tomeczku.core.theme"] = nil
				package.loaded["tomeczku.core.theme.palettes.wallust"] = nil
				package.loaded["tomeczku.core.theme.generated_theme_reloader"] = nil
				vim.schedule(function()
					dofile(vim.fn.stdpath("config") .. "/lua/tomeczku/core/theme/generated_theme_reloader.lua")
					require("todo-comments").reset()
					require("oklch-color-picker.highlight").toggle()
					require("oklch-color-picker.highlight").toggle()
				end)
			end)
		end

		watcher()
	end
end

return M

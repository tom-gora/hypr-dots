local M = {}
local api, map, cmd, notify = vim.api, vim.keymap.set, vim.cmd, vim.notify
local h = require("tomeczku.core.keymaps.helpers")

local set_keymaps = function()
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({
			mode = { "n", "x" },
			{ "<leader>tl", group = "Lua REPL" },
		})
	end

	map("n", "<leader>tll", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "lua") then
			cmd("REPLHideOrFocus lua")
			return
		end
		cmd("REPLStart lua")
	end, h.setOpts({ desc = "Toggle Lua REPL" }))

	map("n", "<leader>tlq", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "lua") then
			cmd("REPLClose lua")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Quit Lua REPL" }))

	map("n", "<leader>tls", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "lua") then
			cmd("REPLSendLine lua")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Send Line to Lua REPL" }))

	map("x", "<leader>tls", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "lua") then
			require("yarepl").commands.send_visual({ args = "lua" })
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Send Selection to Lua REPL" }))
end

M.setup = function()
	set_keymaps()
end

return M

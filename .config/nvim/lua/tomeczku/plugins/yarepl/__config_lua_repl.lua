local M = {}
local api, cmd = vim.api, vim.cmd
local utils = require("tomeczku.plugins.yarepl.__utils")

local set_keymaps = function()
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({
			mode = { "n", "x" },
			{ "<leader>tl", group = "Lua REPL" },
		})
	end

	-- NOTE: Func signature: function(mode, lhs, repl_name, logic, desc, start_new)

	-- Toggle Lua REPL
	utils.map("n", "<leader>tll", "lua", function()
		cmd("REPLHideOrFocus lua")
	end, "Toggle Lua REPL", true)

	-- Quit Lua REPL
	utils.map("n", "<leader>tlq", "lua", function()
		cmd("REPLClose lua")
	end, "Quit Lua REPL", false)

	-- Send Line to Lua REPL
	utils.map("n", "<leader>tls", "lua", function()
		cmd("REPLSendLine lua")
	end, "Send Line to Lua REPL", false)

	-- Send Selection to Lua REPL
	utils.map("x", "<leader>tls", "lua", function()
		require("yarepl").commands.send_visual({ args = "lua" })
	end, "Send Selection to Lua REPL", false)
end

M.setup = function()
	set_keymaps()
end

return M

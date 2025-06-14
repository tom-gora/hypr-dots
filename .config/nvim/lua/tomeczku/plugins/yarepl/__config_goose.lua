local M = {}
local api, cmd = vim.api, vim.cmd
local h = require("tomeczku.core.keymaps.helpers")
local utils = require("tomeczku.plugins.yarepl.__utils")

local set_keymaps = function()
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({
			mode = { "n", "x" },
			{ "<leader>tg", group = "Goose TERM" },
		})
	end
	--
	-- NOTE: Func signature: function(mode, lhs, repl_name, logic, desc, start_new)

	-- Toggle Goose Terminal visibility
	utils.map("n", "<leader>tgg", "goose", function()
		vim.cmd("REPLHideOrFocus goose")
	end, "Toggle Goose Terminal", true)

	-- Send current line to Goose
	utils.map("n", "<leader>tgs", "goose", function()
		cmd("REPLSendLine goose")
	end, "Send Line to Goose", false)

	-- map("n", "<leader>tgs", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "goose") then
	-- 		cmd("REPLSendLine goose")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Send Line to Goose" }))
	--
	-- -- Quit Goose terminal
	-- map("n", "<leader>tgq", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "goose") then
	-- 		cmd("REPLClose goose")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Quit Goose TERM" }))

	-- -- Send current file to Goose
	-- map("n", "<leader>ta+", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /add " .. vim.fn.expand("%:."))
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Send Current File to Goose" }))
	--
	-- -- Drop current file from the chat
	-- map("n", "<leader>ta-", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /drop " .. vim.fn.expand("%:."))
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Drop Current File From Goose" }))
	--
	-- -- Drop all files added to the chat
	-- map("n", "<leader>taD", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /drop")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Drop All Files From Goose" }))
	--
	-- -- Set Goose to ask mode
	-- map("n", "<leader>taA", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /chat-mode ask")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Goose Ask Mode" }))
	--
	-- -- Set Goose to code mode
	-- map("n", "<leader>taC", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /chat-mode code")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Goose Code Mode" }))
	--
	-- -- Set Goose to architect mode
	-- map("n", "<leader>taR", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /chat-mode architect")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Goose Architect Mode" }))
	--
	-- -- Refresh Goose repository map
	-- map("n", "<leader>tam", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /map-refresh")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Goose Refresh Repo Map" }))
	--
	-- -- Print Goose repository map
	-- map("n", "<leader>taM", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		cmd("REPLExec $aider /map")
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Goose Print Repo Map" }))
	--
	-- -- Send visual selection to Goose
	-- map("x", "<leader>tas", function()
	-- 	if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
	-- 		require("yarepl").commands.send_visual({ args = "aider" })
	-- 		return
	-- 	end
	-- 	vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	-- end, h.setOpts({ desc = "Send Selection to Goose" }))
end

M.setup = function()
	set_keymaps()
end

return M

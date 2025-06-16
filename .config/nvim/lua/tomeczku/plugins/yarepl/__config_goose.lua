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

	-- Quit Aider terminal
	utils.map("n", "<leader>tgq", "goose", function()
		cmd("REPLClose goose")
	end, "Quit Goose TERM", false)

	-- Send current line to Goose
	utils.map("n", "<leader>tgs", "goose", function()
		cmd("REPLSendLine goose")
	end, "Send Line to Goose", false)

	-- Set Goose to auto mode
	utils.map("n", "<leader>tgA", "goose", function()
		cmd("REPLExec $goose /mode auto")
	end, "Goose Auto Mode", false)

	-- Set Goose to approve mode
	utils.map("n", "<leader>tgP", "goose", function()
		cmd("REPLExec $goose /mode approve")
	end, "Goose Approve Mode", false)

	-- Set Goose to chat mode
	utils.map("n", "<leader>tgC", "goose", function()
		cmd("REPLExec $goose /mode chat")
	end, "Goose Chat Mode", false)
end

M.setup = function()
	set_keymaps()
end

return M

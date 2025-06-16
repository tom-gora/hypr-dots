-- using https://github.com/HxX2/todocli#
local M = {}
local api, cmd = vim.api, vim.cmd
local utils = require("tomeczku.plugins.yarepl.__utils")

local set_keymaps = function()
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({
			mode = { "n", "x" },
			{ "<leader>tt", group = "Project TODOS" },
		})
	end

	-- Toggle Project TODOS
	utils.map("n", "<leader>ttt", "todo", function()
		cmd("REPLHideOrFocus todo")
	end, "Toggle Project TODOS", true)

	-- Quit Project TODOS
	utils.map("n", "<leader>ttq", "todo", function()
		cmd("REPLClose lua")
	end, "Quit Project TODOS", false)

	-- Init TODOS for Project
	utils.map("n", "<leader>tti", "todo", function()
		cmd("REPLExec $todo clear && todo -i")
	end, "Init TODOS for Project", false)

	-- Add Line as Task to TODOS
	utils.map("n", "<leader>tta", "todo", function()
		local line = vim.api.nvim_get_current_line()
		line = vim.trim(line)
		cmd('REPLExec $todo clear && todo -a "' .. line .. '"')
		vim.cmd("d")
	end, "Init TODOS for Project", false)

	utils.map("n", "<leader>ttd", "todo", function()
		local input = vim.fn.input("Enter task ID to delete: ")

		if input == "" then
			vim.notify("Delete action cancelled.", vim.log.levels.INFO)
			return
		end

		if not input:match("^%d+$") then
			vim.notify("Invalid input. Task ID must be an integer.", vim.log.levels.ERROR)
			return
		end

		local number = tonumber(input)
		vim.cmd("REPLExec $todo todo -r " .. number)
		vim.cmd("REPLExec $todo clear && todo")
	end, "Delete TODO by ID", false)

	vim.keymap.set("n", "<leader>x", function()
		local read_chars = ""
		local keep_reading = nil
		while keep_reading == nil do
			local char = vim.fn.getcharstr()
			read_chars = read_chars .. char
			if tonumber(char) ~= nil then
				keep_reading = "NaN"
			end
		end
		if keep_reading == "Nan" then
			vim.notify("Only numeric input is valid as TODO index.", vim.log.levels.WARN)
		end
	end, { silent = true, noremap = true, desc = "For testing" })
end

M.setup = function()
	set_keymaps()
end

return M

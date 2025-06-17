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

	utils.map("n", "<leader>ttr", "todo", function()
		local count_tasks = function()
			local counter = 0
			local todo_output = vim.trim(vim.fn.system("todo -hp"))
			local output_lines = vim.split(todo_output, "\n", { plain = true })
			for _, line in ipairs(output_lines) do
				line = vim.trim(line)
				if line:match("^%d+") then
					counter = counter + 1
				end
			end
			return counter
		end
		local total_tasks = count_tasks()

		local get_chars = function(total_tasks)
			local chars = ""
			local max_digits = #tostring(total_tasks)
			local countdown = vim.uv.new_timer()

			countdown:start(
				1000,
				0,
				vim.schedule_wrap(function()
					vim.cmd("REPLExec $todo clear && todo -r " .. tonumber(chars))
					-- HACK: Feed dummy esc to kill the loop
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
					countdown:stop()
					countdown:close()
				end)
			)

			while #chars < max_digits do
				local char_ok, char = pcall(vim.fn.getcharstr)
				if char == "\27" then
					return chars
				end
				if not char_ok or char == "" or tonumber(char) == nil then
					return nil
				end
				chars = chars .. char
				if tonumber(chars) > total_tasks then
					return "too_many"
				end
			end
			return chars
		end

		local redraw_scheduler = vim.uv.new_timer()
		redraw_scheduler:start(
			0,
			50,
			vim.schedule_wrap(function()
				vim.cmd("redraw")
			end)
		)
		local read_chars = get_chars(total_tasks)
		redraw_scheduler:stop()
		redraw_scheduler:close()
		if read_chars == nil then
			return
		elseif read_chars == "too_many" then
			vim.notify("There is only " .. tostring(total_tasks) .. " tasks to select from.", vim.log.levels.WARN)
		end
	end, "Remove TODO by ID", false)
end

M.setup = function()
	set_keymaps()
end

return M

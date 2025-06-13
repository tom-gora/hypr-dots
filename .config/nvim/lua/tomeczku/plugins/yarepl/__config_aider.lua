local M = {}
local api, map, cmd = vim.api, vim.keymap.set, vim.cmd
local h = require("tomeczku.core.keymaps.helpers")
local utils = require("tomeczku.plugins.yarepl.__utils")

local set_keymaps = function()
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({
			mode = { "n", "x" },
			{ "<leader>ta", group = "Aider TERM" },
		})
	end

	-- Toggle Aider Terminal visibility
	map("n", "<leader>taa", function()
		local focused_win = api.nvim_get_current_win()
		if not vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLStart aider")
			return
		end
		cmd("REPLHideOrFocus aider")
	end, h.setOpts({ desc = "Toggle Aider Terminal" }))

	-- Send current line to Aider
	map("n", "<leader>tas", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLSendLine aider")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Send Line to Aider" }))

	-- Send current file to Aider
	map("n", "<leader>ta+", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /add " .. vim.fn.expand("%:."))
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Send Current File to Aider" }))

	-- Drop current file from the chat
	map("n", "<leader>ta-", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /drop " .. vim.fn.expand("%:."))
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Drop Current File From Aider" }))

	-- Drop all files added to the chat
	map("n", "<leader>taD", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /drop")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Drop All Files From Aider" }))

	-- Set Aider to ask mode
	map("n", "<leader>taA", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /chat-mode ask")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Ask Mode" }))

	-- Set Aider to code mode
	map("n", "<leader>taC", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /chat-mode code")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Code Mode" }))

	-- Set Aider to architect mode
	map("n", "<leader>taR", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /chat-mode architect")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Architect Mode" }))

	-- Refresh Aider repository map
	map("n", "<leader>tam", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /map-refresh")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Refresh Repo Map" }))

	-- Print Aider repository map
	map("n", "<leader>taM", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /map")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Print Repo Map" }))

	-- Quit Aider terminal
	map("n", "<leader>taq", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLClose aider")
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Quit Aider TERM" }))

	-- Toggle between preferred coding/writing models
	map("n", "<leader>tat", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			local models = _G.AIDER_MODELS
			if not _G.AIDER_WRITING or _G.AIDER_WRITING == false then
				cmd("REPLExec $aider /model " .. models.writing.model)
				cmd("REPLExec $aider /weak-model " .. models.writing.weak_model)
				local msg = "Switched AIDER to writing models."
				msg = msg:gsub('"', '\\"')
				os.execute('notify-send -u normal "Aider" "' .. msg .. '"')
				_G.AIDER_WRITING = not _G.AIDER_WRITING
				return
			end
			cmd("REPLExec $aider /model " .. models.default_coding.model)
			cmd("REPLExec $aider /weak-model " .. models.default_coding.weak_model)
			local msg = "Switched AIDER to coding models."
			msg = msg:gsub('"', '\\"')
			os.execute('notify-send -u normal "Aider" "' .. msg .. '"')
			_G.AIDER_WRITING = not _G.AIDER_WRITING
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Print Repo Map" }))

	-- Send visual selection to Aider
	map("x", "<leader>tas", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			require("yarepl").commands.send_visual({ args = "aider" })
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Send Selection to Aider" }))
end

local set_autocmds = function()
	local aider_helpers = api.nvim_create_augroup("AiderHelpers", { clear = true })
	api.nvim_create_autocmd("TermClose", {
		group = aider_helpers,
		callback = function(e)
			local ok, repl = pcall(api.nvim_buf_get_var, e.buf, "repl")
			if not ok then
				return
			end
			_G.ACTIVE_REPLS = vim.tbl_filter(function(item)
				return not item:match(repl)
			end, _G.ACTIVE_REPLS)
		end,
	})
end

M.args = {
	"--no-auto-commits --stream",
	"--fancy-input",
	"--subtree-only",
	"--config",
	"$HOME/.config/aider/aider-default.conf.yml",
}

M.setup = function()
	_G.AIDER_WRITING = false
	_G.AIDER_MODELS = {
		default_coding = {
			model = "openrouter/google/gemini-2.5-flash-preview-05-20",
			weak_model = "openrouter/qwen/qwen-2.5-coder-32b-instruct",
		},
		writing = {
			model = "openrouter/openai/gpt-4.1-mini",
			weak_model = "openrouter/deepseek/deepseek-prover-v2:free",
		},
	}

	set_keymaps()
	set_autocmds()
end

return M

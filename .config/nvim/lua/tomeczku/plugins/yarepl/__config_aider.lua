-- TODO: add ollama option and integrate into toggling
local M = {}
local api, cmd = vim.api, vim.cmd
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

	-- NOTE: Func signature: function(mode, lhs, repl_name, logic, desc, start_new)

	-- Toggle Aider Terminal visibility
	utils.map("n", "<leader>taa", "aider", function()
		vim.cmd("REPLHideOrFocus aider")
	end, "Toggle Aider Terminal", true)

	-- Quit Aider terminal
	utils.map("n", "<leader>taq", "aider", function()
		cmd("REPLClose aider")
	end, "Quit Aider TERM", false)

	-- Send current line to Aider
	utils.map("n", "<leader>tas", "aider", function()
		cmd("REPLSendLine aider")
	end, "Send Line to Aider", false)

	-- Send current file to Aider
	utils.map("n", "<leader>ta+", "aider", function()
		cmd("REPLExec $aider /add " .. vim.fn.expand("%:."))
	end, "Send Current File to Aider", false)

	-- Drop current file from the chat
	utils.map("n", "<leader>ta-", "aider", function()
		cmd("REPLExec $aider /drop " .. vim.fn.expand("%:."))
	end, "Drop Current File From Aider", false)

	-- Drop all files added to the chat
	utils.map("n", "<leader>taD", "aider", function()
		cmd("REPLExec $aider /drop")
	end, "Drop All Files From Aider", false)

	-- Set Aider to ask mode
	utils.map("n", "<leader>taA", "aider", function()
		cmd("REPLExec $aider /chat-mode ask")
	end, "Aider Ask Mode", false)

	-- Set Aider to code mode
	utils.map("n", "<leader>taC", "aider", function()
		cmd("REPLExec $aider /chat-mode code")
	end, "Aider Code Mode", false)

	-- Set Aider to architect mode
	utils.map("n", "<leader>taR", "aider", function()
		cmd("REPLExec $aider /chat-mode architect")
	end, "Aider Architect Mode", false)

	-- Refresh Aider repository map
	utils.map("n", "<leader>tam", "aider", function()
		cmd("REPLExec $aider /map-refresh")
	end, "Aider Refresh Repo Map", false)

	-- Print Aider repository map
	utils.map("n", "<leader>taM", "aider", function()
		cmd("REPLExec $aider /map")
	end, "Aider Print Repo Map", false)

	-- Toggle between preferred coding/writing models
	utils.map("n", "<leader>tat", "aider", function()
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
	end, "Toggle Aider Models", false)

	-- Send visual selection to Aider
	utils.map("x", "<leader>tas", "aider", function()
		require("yarepl").commands.send_visual({ args = "aider" })
	end, "Send Selection to Aider", false)
end

M.args = {
	"--no-auto-commits --stream",
	"--fancy-input",
	-- "--subtree-only",
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
end

return M

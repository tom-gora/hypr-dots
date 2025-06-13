local M = {}
local api, map, cmd, notify = vim.api, vim.keymap.set, vim.cmd, vim.notify
local h = require("tomeczku.core.keymaps.helpers")

local set_keymaps = function()
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({
			mode = { "n", "x" },
			{ "<leader>ta", group = "Aider TERM" },
		})
	end

	map("n", "<leader>taa", function()
		local focused_win = api.nvim_get_current_win()
		if not _G.AIDER_RUNNING or _G.AIDER_RUNNING == nil then
			cmd("REPLStart aider")
			return
		end
		cmd("REPLHideOrFocus aider")
	end, h.setOpts({ desc = "Toggle Aider Terminal" }))

	map("n", "<leader>tas", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLSendLine aider")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Send Line to Aider" }))

	map("n", "<leader>taf", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /add " .. vim.fn.expand("%:p"))
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Send File to Aider" }))

	map("n", "<leader>taA", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /chat-mode ask")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Ask Mode" }))

	map("n", "<leader>taC", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /chat-mode code")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Code Mode" }))

	map("n", "<leader>taR", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /chat-mode architect")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Architect Mode" }))

	map("n", "<leader>tam", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /map-refresh")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Refresh Repo Map" }))

	map("n", "<leader>taM", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			cmd("REPLExec $aider /map")
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, h.setOpts({ desc = "Aider Print Repo Map" }))

	map("x", "<leader>tas", function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, "aider") then
			require("yarepl").commands.send_visual({ args = "aider" })
			return
		end
		notify("REPL doesn't exist!", vim.log.levels.INFO)
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
			local term_file = e.file or e.match
			if
				not term_file
				or not string.find(string.lower(term_file), "aider")
				or not _G.AIDER_RUNNING
				or _G.AIDER_RUNNING == nil
			then
				return
			end
			_G.AIDER_RUNNING = nil
		end,
	})
end

M.args = {
	"--no-auto-commits --stream",
	"--fancy-input",
	--"--subtree-only",
	"--config",
	"$HOME/.config/aider/aider-default.conf.yml",
}

M.setup = function()
	_G.AIDER_MODELS = {
		default_coding = {
			model = "openrouter/google/gemini-2.5-flash-preview-05-2",
			weak_model = "openrouter/qwen/qwen-2.5-coder-32b-instruct",
		},
		writing = {
			model = "openrouter/google/gemini-2.5-flash-preview",
			weak_model = "openrouter/deepseek/deepseek-prover-v2:free",
		},
	}

	set_keymaps()
	set_autocmds()
end

return M

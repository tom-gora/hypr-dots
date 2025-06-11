local M, aider_opts, config_function

aider_opts = {
	aider_cmd = "TERM=xterm-256color aider",
	args = {
		"--no-auto-commits",
		"--stream",
		"--fancy-input",
		--"--subtree-only",
		"--config",
		"$HOME/.config/aider/aider-default.conf.yml",
	},
	theme = {
		user_input_color = "#c4a7e7",
		tool_output_color = "#3e8fb0",
		tool_error_color = "#eb6f92",
		tool_warning_color = "#f6c177",
		assistant_output_color = "#9ccfd8",
		completion_menu_color = "#e0def4",
		completion_menu_bg_color = "#14161b",
		completion_menu_current_color = "#C18FFF",
		completion_menu_current_bg_color = "#14161b",
	},
	auto_reload = true,
	-- dependencies = {
	-- 	"folke/snacks.nvim",
	-- },
	picker_cfg = {
		cycle = false,
		preset = function()
			return vim.o.columns >= 106 and "ivy" or "right"
		end,
	},
	win = {
		wo = { winbar = "  AIDER" },
	},
}

config_function = function()
	-- set globals for aider integrations
	_G.AIDER_RUNNING = false
	_G.AIDER_WRITING = false
	_G.AIDER_MODELS = {
		default_coding = {
			model = "openrouter/openai/gpt-4o-mini",
			weak_model = "openrouter/qwen/qwen-2.5-coder-32b-instruct",
		},
		writing = {
			model = "openrouter/google/gemini-2.5-flash-preview",
			weak_model = "openrouter/deepseek/deepseek-prover-v2:free",
		},
	}
	-- call plugin setup
	require("nvim_aider").setup(aider_opts)
end

M = {
	{
		"GeorgesAlkhouri/nvim-aider",
		enabled = false,
		cmd = "Aider",
		config = config_function,
	},
	{
		"joshuavial/aider.nvim",
		opts = {
			-- your configuration comes here
			-- if you don't want to use the default settings
			auto_manage_context = true, -- automatically manage buffer context
			default_bindings = true, -- use default <leader>A keybindings
			debug = false, -- enable debug logging
			ignore_buffers = { "^term://", "NeogitConsole", "NvimTree_", "neo-tree filesystem", "oil" },
		},
	},
}

return M

-- autocmd({ "TermOpen", "TermClose" }, {
-- 	group = ui_helpers,
-- 	callback = function(e)
-- 		local api = vim.api
-- 		local term_file = e.file or e.match
-- 		if not term_file or not term_file:match(":aider") then
-- 			return
-- 		end
--
-- 		local term_win = api.nvim_get_current_win()
-- 		local term_buf = e.buf
--
-- 		if e.event == "TermOpen" then
-- 			api.nvim_win_set_option(term_win, "winhighlight", "Normal:NormalFloat")
--
-- 			local fractional_width = math.floor(vim.o.columns * 0.4)
-- 			local capped_width = math.max(fractional_width, 50)
-- 			api.nvim_win_set_width(term_win, capped_width)
--
-- 			api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
-- 				buffer = term_buf,
-- 				callback = function()
-- 					local current_win = vim.api.nvim_get_current_win()
-- 					vim.api.nvim_win_set_option(current_win, "winhighlight", "Normal:NormalFloat")
-- 				end,
-- 			})
--
-- 			_G.AIDER_RUNNING = true
-- 		elseif e.event == "TermClose" then
-- 			_G.AIDER_RUNNING = false
-- 		end
-- 	end,
-- })
--
--
--
-- AI integration
-- ["<leader>aa"] = { "<cmd>Aider toggle<cr>", h.setOpts({ desc = "Toggle Aider" }) },
-- ["<leader>ap"] = { "<cmd>Aider command<cr>", h.setOpts({ desc = "Aider Pick Command" }) },
-- ["<leader>ab"] = { "<cmd>Aider buffer<cr>", h.setOpts({ desc = "Send Buffer" }) },
-- ["<leader>a+"] = { "<cmd>Aider add<cr>", h.setOpts({ desc = "Add File" }) },
-- ["<leader>a-"] = { "<cmd>Aider drop<cr>", h.setOpts({ desc = "Drop File" }) },
-- ["<leader>ar"] = { "<cmd>Aider add readonly<cr>", h.setOpts({ desc = "Add Read-Only" }) },
-- ["<leader>aR"] = { "<cmd>Aider reset<cr>", h.setOpts({ desc = "Reset Session" }) },
-- ["<leader>at"] = { h.toggleAiderModels, h.setOpts({ desc = "Writing Models" }) },
--
--
-- M.toggleAiderModels = function()
-- 	local at = require("nvim_aider.terminal")
-- 	local models = _G.AIDER_MODELS
-- 	if not _G.AIDER_WRITING or _G.AIDER_WRITING ~= true then
-- 		at.command("/model " .. models.default_coding.model)
-- 		at.command("/weak-model " .. models.default_coding.weak_model)
-- 		-- vim.notify("Switched to writing models.", vim.log.levels.INFO)
-- 		local txt = "Switched to writing models."
-- 		local msg = txt:gsub('"', '\\"')
-- 		os.execute('notify-send -u normal "Aider" "' .. msg .. '"')
-- 	else
-- 		at.command("/model " .. models.writing.model)
-- 		at.command("/weak-model " .. models.writing.weak_model)
-- 		-- vim.notify("Switched to coding models.", vim.log.levels.INFO)
-- 		local txt = "Switched to coding models."
-- 		local msg = txt:gsub('"', '\\"')
-- 		os.execute('notify-send -u normal "Aider" "' .. msg .. '"')
-- 	end
-- 	_G.AIDER_WRITING = not _G.AIDER_WRITING
-- end
--
-- aider integration
-- ["<leader>a"] = { " AI" },
-- ["<leader>as"] = { "<cmd>Aider send<cr>", h.setOpts({ desc = "Send to Aider" }) },
--

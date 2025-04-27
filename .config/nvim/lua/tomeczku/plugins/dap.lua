local M
local arrows = {
	right = "",
	left = "",
	up = "",
	down = "",
}

-- Set up icons.
local icons = {
	Stopped = { "", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint = "",
	BreakpointCondition = "",
	BreakpointRejected = { "", "DiagnosticError" },
	LogPoint = arrows.right,
}

for name, sign in pairs(icons) do
	sign = type(sign) == "table" and sign or { sign }
	vim.fn.sign_define("Dap" .. name, {
        -- stylua: ignore
        text = sign[1] --[[@as string]] .. ' ',
		texthl = sign[2] or "DiagnosticInfo",
		linehl = sign[3],
		numhl = sign[3],
	})
end

local uiopts = {
	icons = {
		collapsed = arrows.right,
		current_frame = arrows.right,
		expanded = arrows.down,
	},
	floating = { border = "rounded" },
	layouts = {
		{
			elements = {
				{ id = "stacks", size = 0.30 },
				{ id = "breakpoints", size = 0.20 },
				{ id = "scopes", size = 0.50 },
			},
			position = "left",
			size = 40,
		},
	},
}

local dapconfig = function()
	local map, dap, ui, w = vim.keymap.set, require("dap"), require("dapui"), require("dap.ui.widgets")

	ui.setup(uiopts)
	--
	--
	-- hook ui to dap events
	dap.listeners.before.attach.dapui_config = function()
		ui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		ui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		ui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		ui.close()
	end
	--
	-- nvim
	dap.configurations.lua = {
		{
			type = "nlua",
			request = "attach",
			name = "Attach to running Neovim instance",
		},
	}

	dap.adapters.nlua = function(callback, config)
		callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
	end
	--
	-- set keybinds for dap functions
	--
	local defaults = { noremap = true, silent = true }
	-- Continue debugging
	map("n", "<leader>dc", function()
		dap.continue()
	end, vim.tbl_extend("force", defaults, { desc = "Continue debugging" }))

	-- Step over the next
	map("n", "<leader>do", function()
		dap.step_over()
	end, vim.tbl_extend("force", defaults, { desc = "Step over the next instruction" }))

	-- Step into function call
	map("n", "<leader>di", function()
		dap.step_into()
	end, vim.tbl_extend("force", defaults, { desc = "Step into function call" }))

	-- Step out of function call
	map("n", "<leader>dO", function()
		dap.step_out()
	end, vim.tbl_extend("force", defaults, { desc = "Step out of function call" }))

	-- Toggle breakpoint
	map("n", "<Leader>db", function()
		dap.toggle_breakpoint()
	end, vim.tbl_extend("force", defaults, { desc = "Toggle breakpoint" }))

	-- Set a new breakpoint with message input
	map("n", "<Leader>dB", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, vim.tbl_extend("force", defaults, { desc = "Set a new breakpoint with message" }))

	-- Open the debug REPL
	map("n", "<Leader>dr", function()
		dap.repl.open()
	end, vim.tbl_extend("force", defaults, { desc = "Open the debug REPL" }))

	-- Show hover information
	map({ "n", "v" }, "<Leader>dh", function()
		w.hover()
	end, vim.tbl_extend("force", defaults, { desc = "Show hover information" }))

	-- Show preview information
	map({ "n", "v" }, "<Leader>dp", function()
		w.preview()
	end, vim.tbl_extend("force", defaults, { desc = "Show preview information" }))

	-- Show debug frames in a centered float
	map("n", "<Leader>df", function()
		w.centered_float(w.frames)
	end, vim.tbl_extend("force", defaults, { desc = "Show debug frames in a centered float" }))

	-- Show scopes in a centered float
	map("n", "<Leader>ds", function()
		w.centered_float(w.scopes)
	end, vim.tbl_extend("force", defaults, { desc = "Show scopes in a centered float" }))
	--
	-- start lua nvim debug
	map("n", "<leader>dl", function()
		local ok, osv = pcall(require, "osv")
		if ok then
			osv.launch({ port = 8086 })
			local messages = vim.fn.execute("messages")
			local it = vim.iter(vim.split(messages, "\n"))
			vim.notify(it:last())
		else
			vim.notify("Couldnt connect to nvim debug adaper!", vim.log.levels.ERROR)
		end
	end, vim.tbl_extend("force", defaults, { desc = "Start LUA Nvim Debug Server" }))
end

M = {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		{ "mfussenegger/nvim-dap", config = dapconfig },
		"nvim-neotest/nvim-nio",
		{
			"jbyuki/one-small-step-for-vimkind",
			-- LOAD FIRST!
			priority = 1000,
			-- This config will run as soon as the plugin is loaded
			config = function()
				-- NOTE: START SERVER IF DEBUG BOOL IS SET
				if init_debug then
					local ok, osv = pcall(require, "osv")
					if not ok then
						vim.notify("Failed to require OSV module: " .. tostring(osv), vim.log.levels.ERROR)
						return
					end

					vim.notify("Successfully required OSV. Launching debugger...", vim.log.levels.INFO)
					local ok_launch, err_launch = pcall(osv.launch, {
						port = 8086,
						blocking = true,
					})

					if not ok_launch then
						vim.notify("Failed to launch debugger! Error: " .. tostring(err_launch), vim.log.levels.ERROR)
						return
					end

					vim.notify("OSV debugger launched and waiting for connection...", vim.log.levels.INFO)
				end
			end,
			-- Make it a dependency of other plugins that you want to debug
			-- This ensures it's loaded before them
			-- For example, if you want to debug your custom plugins:
			cond = function()
				-- Only load this plugin if we're in debug mode
				return init_debug
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = { virt_text_pos = "eol" },
		},
	},
}

return M

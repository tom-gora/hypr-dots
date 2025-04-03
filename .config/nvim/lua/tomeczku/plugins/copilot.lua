if vim.g.vscode then
	return
end

local M, config_function

config_function = function()
	-- only setup if global state control value is set ( and it's not by default )
	-- just an extra ensure check as setup is meant to only be called by toggling func
	local is_off = vim.g.copilot_enabled
	if not is_off then
		-- setup own false augroup to prevent inbuilt teardown from erroring out due to lack
		-- of internally set up augroup
		-- (setup's not been called yet. We are killing it right away in the womb xd)
		vim.api.nvim_create_augroup("copilot.client", { clear = true })
		-- wrap things down forcefully using inbuilt client function
		require("copilot.client").teardown()
	else
		local copilot = require("copilot")
		copilot.setup({
			suggestions = { enabled = false },
			panel = { enabled = false },
		})
	end
end

M = {
	"zbirenbaum/copilot.lua",
	cond = vim.g.vscode == nil,
	cmd = "Copilot",
	event = "InsertEnter",
	config = config_function,
}

return M

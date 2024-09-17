local M = {}

-- src https://github.com/supermaven-inc/supermaven-nvim/issues/81#issuecomment-2348608496
M.config_function = function(_, opts)
	require("supermaven-nvim").setup(opts)
	local api = require("supermaven-nvim.api")
	-- stop supermaven at start if running
	-- because it will start automatically through setup()
	if api.is_running() then
		api.stop()
	end
end

M.opts = {
	log_level = "off",
	-- disable inline ai as I prefer using cmp suggestions
	disable_inline_completion = true,
	disable_keymaps = true,
	condition = function()
		-- use global variable for stop condition
		return not vim.g.supermaven_enable
	end,
}

return M

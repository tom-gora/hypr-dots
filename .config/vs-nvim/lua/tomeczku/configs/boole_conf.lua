local M = {}

M.opts = {
	mappings = {
		increment = "<C-a>",
		decrement = "<C-x>",
	},
	-- User defined loops
	-- additions = {
	--   { 'Foo', 'Bar' },
	--   { 'tic', 'tac', 'toe' }
	-- },
	allow_caps_additions = {
		{ "enable", "disable" },
		{ "off", "on" },
		-- enable → disable
		-- Enable → Disable
		-- ENABLE → DISABLE
	},
}

return M

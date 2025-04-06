-- vim options
require("tomeczku.core.vim_opts")
-- bootstrap lazy.nvim
require("tomeczku.core.bootstrap_lazy")
-- my user commands
require("tomeczku.core.user_commands")
-- extra filetypes registered
require("tomeczku.core.extra_filetypes")
if not vim.g.vscode then
	-- keymaps
	require("tomeczku.core.keymaps").setup()
	-- bring int autocommands
	require("tomeczku.core.autocommands")
	-- get statuslinme
	require("tomeczku.core.custom_statusline")
	-- miscellaneous
	require("tomeczku.core.misc")
elseif vim.g.vscode == 1 then
	local vs_code_things = require("tomeczku.vs_code")
	vs_code_things.vscode_other.vim_opts_and_other_basics()
	-- setup autocommands to still work in vscode
	vs_code_things.vscode_other.autocommands()
	-- keybinds triggered from nvim to avoid building complex when sections in vscodevscode-neovim
	vs_code_things.vscode_register_keymaps()
end

vim.g.legacy_cmp = false

-- stop ai completions by default on startup
local ok, s_api = pcall(require, "supermaven-nvim.api")
if ok and not s_api.is_running() then
	vim.schedule(s_api.stop)
end

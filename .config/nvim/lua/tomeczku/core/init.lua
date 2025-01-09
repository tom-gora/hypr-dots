-- vim options
require("tomeczku.core.vim_opts")
-- bootstrap lazy.nvim
require("tomeczku.core.bootstrap_lazy")
-- my hl groups overrides
require("tomeczku.core.highlights")
-- my user commands
require("tomeczku.core.user_commands")
if not vim.g.vscode then
	-- keymaps
	require("tomeczku.core.keymaps")
	-- winZap
	-- require("tomeczku.core.winZap")
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

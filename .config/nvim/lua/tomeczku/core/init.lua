vim.g.legacy_cmp = false
vim.g.health = { style = "float" }

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
	-- native lsp setup
	require("tomeczku.core.lsp").setup()
	-- get statuslinme
	require("tomeczku.core.custom_statusline")
	-- call global diagnostics config last to override producers
	require("tomeczku.core.lsp.diagnostics").setup()
elseif vim.g.vscode == 1 then
	local vs_code_things = require("tomeczku.vs_code")
	vs_code_things.vscode_other.vim_opts_and_other_basics()
	-- setup autocommands to still work in vscode
	vs_code_things.vscode_other.autocommands()
	-- keybinds triggered from nvim to avoid building complex when sections in vscodevscode-neovim
	vs_code_things.vscode_register_keymaps()
end

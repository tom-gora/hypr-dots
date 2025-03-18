--
-- tailwind configs that work found here:
-- https://github.com/Wansmer/nvim-config/blob/4d7fa6c02474f38755202e679cb7e398b5e96e44/lua/config/plugins/cmp.lua#L121
--
--

local M

local conf

if not vim.g.vscode then
	conf = require("tomeczku.configs.cmp_conf")
end

-- M = {
-- 	"hrsh7th/nvim-cmp",
-- 	cond = vim.g.vscode == nil,
-- 	lazy = true,
-- 	event = "InsertEnter",
-- 	dependencies = conf.cmp_dependencies,
-- 	config = conf.cmp_config_function,
-- }

M = {
	"saghen/blink.cmp",
	version = "0.13.1",
	event = "InsertEnter",
	dependencies = conf.blink_dependencies,
	build = "cargo build --release",
	opts = conf.blink_opts,
}

return M

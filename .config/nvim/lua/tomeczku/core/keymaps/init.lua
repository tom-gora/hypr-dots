local n = require("tomeczku.core.keymaps.normal")
local x = require("tomeczku.core.keymaps.visual")
local i = require("tomeczku.core.keymaps.insert")
local nx = require("tomeczku.core.keymaps.normal+visual")
local t = require("tomeczku.core.keymaps.term")
local o = require("tomeczku.core.keymaps.other")

local M = {}

M.setup = function()
	local map = vim.keymap.set
	-- loop over normal bindings and set the keymaps
	for k, v in pairs(n) do
		map("n", k, v[1], v[2])
	end

	-- loop over insert bindings and set the keymaps
	for k, v in pairs(i) do
		map("i", k, v[1], v[2])
	end

	-- loop over visual bindings and set the keymaps
	for k, v in pairs(x) do
		map("x", k, v[1], v[2])
	end

	-- loop over normal+visual bindings and set the keymaps
	for k, v in pairs(nx) do
		map({ "n", "x" }, k, v[1], v[2])
	end

	-- loop over term bindings and set the keymaps
	for k, v in pairs(t) do
		map("t", k, v[1], v[2])
	end

	-- call other setups and hacks
	o.setupCmdlineAndWildmenu()
	o.nonDestructivePaste()
	o.wkProxies()
	o.disableDefaults()
end

return M

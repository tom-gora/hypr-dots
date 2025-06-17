local h = require("tomeczku.core.keymaps.helpers")
local ft_maps = require("tomeczku.core.keymaps.filetype_specific")
local other_maps = require("tomeczku.core.keymaps.other")
local count_capture = require("tomeczku.utils.count_capture") -- New: Require the count_capture module

-- Normal mode keymaps
local n = {
	-- General
	["<leader>w"] = { "<cmd>w<cr>", h.setOpts({ desc = "Save" }) },
	["<leader>q"] = { "<cmd>q<cr>", h.setOpts({ desc = "Quit" }) },
	["<leader>Q"] = { "<cmd>qa!<cr>", h.setOpts({ desc = "Quit All" }) },
	["<leader>s"] = { "<cmd>w<cr>", h.setOpts({ desc = "Save" }) },
	["<leader>x"] = { "<cmd>x<cr>", h.setOpts({ desc = "Save and Quit" }) },
	["<leader>c"] = { "<cmd>noh<cr>", h.setOpts({ desc = "Clear Search Highlight" }) },
	["<leader>f"] = { "<cmd>Format<cr>", h.setOpts({ desc = "Format" }) },
	["<leader>r"] = { "<cmd>source %<cr>", h.setOpts({ desc = "Source File" }) },
	["<leader>u"] = { "<cmd>UndotreeToggle<cr>", h.setOpts({ desc = "Undo Tree" }) },
	["<leader>y"] = { "<cmd>YankHistory<cr>", h.setOpts({ desc = "Yank History" }) },
	["<leader>p"] = { "<cmd>Paste<cr>", h.setOpts({ desc = "Paste" }) },
	["<leader>d"] = { "<cmd>DiffviewOpen<cr>", h.setOpts({ desc = "Diffview" }) },
	["<leader>D"] = { "<cmd>DiffviewClose<cr>", h.setOpts({ desc = "Diffview Close" }) },
	["<leader>t"] = { "<cmd>TodoTelescope<cr>", h.setOpts({ desc = "Todo" }) },
	["<leader>T"] = { "<cmd>TodoQuickfix<cr>", h.setOpts({ desc = "Todo Quickfix" }) },
	["<leader>z"] = { "<cmd>ZenMode<cr>", h.setOpts({ desc = "Zen Mode" }) },
	["<leader>Z"] = { "<cmd>ZenMode<cr>", h.setOpts({ desc = "Zen Mode" }) },
	["<leader>v"] = { "<cmd>vsplit<cr>", h.setOpts({ desc = "Vertical Split" }) },
	["<leader>h"] = { "<cmd>split<cr>", h.setOpts({ desc = "Horizontal Split" }) },
	["<leader>b"] = { "<cmd>BufferLineCycleNext<cr>", h.setOpts({ desc = "Next Buffer" }) },
	["<leader>B"] = { "<cmd>BufferLineCyclePrev<cr>", h.setOpts({ desc = "Previous Buffer" }) },
	["<leader>n"] = { "<cmd>BufferLineCloseOthers<cr>", h.setOpts({ desc = "Close Other Buffers" }) },
	["<leader>N"] = { "<cmd>BufferLineCloseLeft<cr>", h.setOpts({ desc = "Close Left Buffers" }) },
	["<leader>M"] = { "<cmd>BufferLineCloseRight<cr>", h.setOpts({ desc = "Close Right Buffers" }) },
	["<leader>C"] = { "<cmd>BufferLinePick<cr>", h.setOpts({ desc = "Pick Buffer" }) },
	["<leader>V"] = { "<cmd>BufferLineSortByDirectory<cr>", h.setOpts({ desc = "Sort Buffers by Directory" }) },
	["<leader>P"] = { "<cmd>BufferLineSortByExtension<cr>", h.setOpts({ desc = "Sort Buffers by Extension" }) },
	["<leader>A"] = { "<cmd>BufferLineSortByRelativeDirectory<cr>", h.setOpts({ desc = "Sort Buffers by Relative Directory" }) },
	["<leader>S"] = { "<cmd>BufferLineSortByTabs<cr>", h.setOpts({ desc = "Sort Buffers by Tabs" }) },
	["<leader>L"] = { "<cmd>BufferLineSortByHistory<cr>", h.setOpts({ desc = "Sort Buffers by History" }) },
	["<leader>R"] = { "<cmd>BufferLineSortByBufferNumber<cr>", h.setOpts({ desc = "Sort Buffers by Buffer Number" }) },
	["<leader>G"] = { "<cmd>BufferLineSortByFileName<cr>", h.setOpts({ desc = "Sort Buffers by File Name" }) },
	["<leader>X"] = { "<cmd>BufferLineSortByModified<cr>", h.setOpts({ desc = "Sort Buffers by Modified" }) },
	["<leader>Y"] = { "<cmd>BufferLineSortByCreated<cr>", h.setOpts({ desc = "Sort Buffers by Created" }) },
	["<leader>W"] = { "<cmd>BufferLineSortByAccessed<cr>", h.setOpts({ desc = "Sort Buffers by Accessed" }) },
	["<leader>E"] = { "<cmd>BufferLineSortByLastAccessed<cr>", h.setOpts({ desc = "Sort Buffers by Last Accessed" }) },
	["<leader>O"] = { "<cmd>BufferLineSortByLastModified<cr>", h.setOpts({ desc = "Sort Buffers by Last Modified" }) },
	["<leader>K"] = { "<cmd>BufferLineSortByLastCreated<cr>", h.setOpts({ desc = "Sort Buffers by Last Created" }) },
	["<leader>J"] = { "<cmd>BufferLineSortByLastAccessed<cr>", h.setOpts({ desc = "Sort Buffers by Last Accessed" }) },
	["<leader>H"] = { "<cmd>BufferLineSortByLastModified<cr>", h.setOpts({ desc = "Sort Buffers by Last Modified" }) },
	["<leader>I"] = { "<cmd>BufferLineSortByLastCreated<cr>", h.setOpts({ desc = "Sort Buffers by Last Created" }) },
	["<leader>U"] = { "<cmd>BufferLineSortByLastAccessed<cr>", h.setOpts({ desc = "Sort Buffers by Last Accessed" }) },
	["<leader>F"] = { "<cmd>BufferLineSortByLastModified<cr>", h.setOpts({ desc = "Sort Buffers by Last Modified" }) },
	["<leader>L"] = { "<cmd>BufferLineSortByLastCreated<cr>", h.setOpts({ desc = "Sort Buffers by Last Created" }) },
	["<leader>M"] = { "<cmd>BufferLineSortByLastAccessed<cr>", h.setOpts({ desc = "Sort Buffers by Last Accessed" }) },
	["<leader>N"] = { "<cmd>BufferLineSortByLastModified<cr>", h.setOpts({ desc = "Sort Buffers by Last Modified" }) },
	["<leader>O"] = { "<cmd>BufferLineSortByLastCreated<cr>", h.setOpts({ desc = "Sort Buffers by Last Created" }) },
	["<leader>P"] = { "<cmd>BufferLineSortByLastAccessed<cr>", h.setOpts({ desc = "Sort Buffers by Last Accessed" }) },
	["<leader>Q"] = { "<cmd>BufferLineSortByLastModified<cr>", h.setOpts({ desc = "Sort Buffers by Last Modified" }) },
	["<leader>R"] = { "<cmd>BufferLineSortByLastCreated<cr>", h.setOpts({ desc = "Sort Buffers by Last Created" }) },
	["<leader>S"] = { "<cmd>BufferLineSortByLastAccessed<cr>", h.setOpts({ desc = "Sort Buffers by Last Accessed" }) },
	["<leader>T"] = { "<cmd>BufferLineSortByLastModified<cr>", h.setOpts({ desc = "Sort Buffers by Last Modified" }) },

	-- New: Example of using count_capture
	-- Map 'gX' to initiate count capture
	["gX"] = {
		function()
			count_capture.start_capture(function(count, reason)
				vim.notify(string.format("Operator 'gX' received count: %d (Reason: %s)", count, reason), vim.log.levels.INFO)
				-- Example: Move 'count' lines down
				vim.cmd(string.format("normal! %dj", count))
			end)
			-- Immediately finish capture if 'gX' is pressed without a count
			-- This allows 'gX' to work as '1gX' if no digits are typed
			count_capture.finish_capture("operator_pressed")
		end,
		h.setOpts({ desc = "My custom operator with count" }),
	},
}

-- Insert mode keymaps
local i = {
	-- Example: Map jk to <Esc>
	["jk"] = { "<Esc>", h.setOpts({ desc = "Escape" }) },
}

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

	-- Filetype-specific keymaps
	ft_maps.lua()
	ft_maps.markdown()
	ft_maps.laravel()
	ft_maps.help()
	ft_maps.trouble()
	ft_maps.quickfix()

	-- Other keymaps
	other_maps.setup()
end

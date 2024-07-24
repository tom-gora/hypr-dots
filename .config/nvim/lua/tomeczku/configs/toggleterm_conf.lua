local M = {}

M.opts = {
	open_mapping = [[<S-CR>]],
	direction = "horizontal",
	persist_mode = false,
	auto_scroll = true,
	start_in_insert = true,
	size = function(term)
		if term.direction == "horizontal" then
			return 20
		elseif term.direction == "vertical" then
			return math.floor(vim.o.columns * 0.3)
		end
	end,
	float_opts = {
		border = "curved",
		width = function()
			return math.floor(vim.o.columns * 0.45)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.92)
		end,
		col = function()
			local w = math.floor(vim.o.columns * 0.45)
			return vim.o.columns - (w + 3)
		end,
		row = function()
			return 1
		end,
		zindex = 10,
		title_pos = "center",
	},
	winbar = { enabled = false },
	shade_terminals = false,
	highlights = {
		Normal = {
			guibg = "NONE",
		},
		NormalFloat = {
			guibg = "NONE",
		},
		FloatBorder = {
			guifg = "#8bbec7",
		},
	},
}

M.config_function = function(_, opts)
	require("toggleterm").setup(opts)
	-- REGISTER MY CUSTOM TERMINALS:
	local Terminal = require("toggleterm.terminal").Terminal
	-- node terminal
	local node_term = Terminal:new({ cmd = "node", direction = "float" })
	-- btop terminal
	local btop_term = Terminal:new({ cmd = "btop", direction = "float" })

	local set_term_title = function(title)
		if vim.bo.filetype == "toggleterm" then
			vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
				title = title,
				title_pos = "left",
			})
		end
	end

	-- functions to call them
	function _NODE_toggle()
		node_term:toggle()
		set_term_title("  Node ")
	end

	function _BTOP_toggle()
		btop_term:toggle()
		set_term_title("  BTOP ")
	end

	-- navigation set as per toggleterm docs
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	-- set keymaps for terms
	vim.api.nvim_set_keymap(
		"n",
		"<leader>tn",
		"<cmd>lua _NODE_toggle()<CR>",
		{ noremap = true, silent = true, desc = "Toggle NODE terminal" }
	)

	vim.api.nvim_set_keymap(
		"n",
		"<leader>tb",
		"<cmd>lua _BTOP_toggle()<CR>",
		{ noremap = true, silent = true, desc = "Toggle BTOP terminal" }
	)
end

return M

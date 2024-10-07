local M = {}

M.opts = {
	open_mapping = [[<S-CR>]],
	direction = "horizontal",
	persist_mode = false,
	auto_scroll = true,
	start_in_insert = false,
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
			guibg = "#191724",
		},
		NormalFloat = {
			guibg = "#191724",
		},
		FloatBorder = {
			guifg = "#8bbec7",
		},
	},
}

M.config_function = function(_, opts)
	require("toggleterm").setup(opts)
	local api = vim.api
	-- REGISTER MY CUSTOM TERMINALS:
	local Terminal = require("toggleterm.terminal").Terminal
	-- node terminal
	local node_term = Terminal:new({ cmd = "node", direction = "float" })
	-- btop terminal
	local btop_term = Terminal:new({ cmd = "btop", direction = "float" })
	-- go runner
	local root_patterns = { ".git", ".clang-format", "go.mod", "package.json", "cargo.toml" }
	local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1]) or vim.uv.cwd()
	if not root_dir then
		print("Error: Could not find the project's root directory.")
	end

	-- for go runner
	local function find_main_go()
		local main_go_files = vim.fs.find("main.go", { path = root_dir, type = "file", limit = 10 })
		-- extra check if multiple main.go files found from any other packages....
		for _, file in ipairs(main_go_files) do
			-- confirm package declaration for "main" is in the located main.go
			local fd = io.open(file, "r")
			if fd then
				local content = fd:read("*a")
				fd:close()
				if content:match("package%s+main") then
					return file
				end
			end
		end
		return nil
	end
	local go_main_package_dir = find_main_go()

	if not go_main_package_dir then
		print("Error: Could not find the main.go file.")
		return
	end

	local go_runner_term = Terminal:new({
		float_opts = { relative = "editor", focusable = false },
		cmd = "go run " .. go_main_package_dir,
		direction = "float",
		close_on_exit = false,
		auto_scroll = true,
		start_in_insert = true,
	})

	local set_term_title = function(title, buf_title)
		if vim.bo.filetype == "toggleterm" then
			api.nvim_buf_set_name(0, buf_title)
			api.nvim_win_set_config(api.nvim_get_current_win(), {
				title = title,
				title_pos = "left",
			})
		end
	end

	local spawn_go_runner = function()
		vim.cmd("silent wa")
		go_runner_term:toggle()
		set_term_title("  Go Runner ", "go_runner")
		vim.cmd("wincmd h")
	end

	api.nvim_create_user_command("SpawnNodeTerminal", function()
		node_term:toggle()
		set_term_title("  Node ", "node")
	end, {
		desc = "Spawn Node terminal",
		bang = true,
	})

	api.nvim_create_user_command("SpawnBtopTerminal", function()
		btop_term:toggle()
		set_term_title("  BTOP ", "btop")
	end, {
		desc = "Spawn Btop terminal",
		bang = true,
	})

	api.nvim_create_user_command("ToggleGoRunner", function()
		local winlist = api.nvim_list_wins()
		local runner_on = { runner_win = nil, runner_buf = nil, found = false }
		-- check if such term is already open
		for _, win in ipairs(winlist) do
			local bufname = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
			local bufnr = api.nvim_win_get_buf(win)
			if string.find(bufname, "go_runner", 1, true) then
				runner_on = { runner_win = win, runner_buf = bufnr, found = true }
			end
		end
		if runner_on.found and runner_on.runner_win ~= nil and runner_on.runner_buf ~= nil then
			api.nvim_win_close(runner_on.runner_win, true)
		else
			go_runner_term:toggle()
			set_term_title("  Go Runner ", "go_runner")
			vim.cmd("wincmd h")
		end
	end, {
		bang = true,
	})

	api.nvim_create_user_command("RunGoProject", function()
		local winlist = api.nvim_list_wins()
		local runner_on = { runner_win = nil, runner_buf = nil, found = false }
		-- check if such term is already open
		for _, win in ipairs(winlist) do
			local bufname = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
			local bufnr = api.nvim_win_get_buf(win)
			if string.find(bufname, "go_runner", 1, true) then
				runner_on = { runner_win = win, runner_buf = bufnr, found = true }
			end
		end
		if runner_on.found and runner_on.runner_win ~= nil and runner_on.runner_buf ~= nil then
			api.nvim_win_close(runner_on.runner_win, true)
			api.nvim_buf_delete(runner_on.runner_buf, { force = true })
			spawn_go_runner()
		else
			spawn_go_runner()
		end
	end, {
		bang = true,
	})

	-- for term navigation

	-- navigation set as per toggleterm docs
	local term_augroup = vim.api.nvim_create_augroup("termBinds", { clear = true })

	api.nvim_create_autocmd("TermOpen", {
		group = term_augroup,
		callback = function()
			local bind_opts = { buffer = 0 }
			local map = vim.keymap.set
			map("t", "<esc>", [[<C-\><C-n>]], bind_opts)
			map("t", "jk", [[<C-\><C-n>]], bind_opts)
			map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], bind_opts)
			map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], bind_opts)
			map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], bind_opts)
			map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], bind_opts)
			map("t", "<C-w>", [[<C-\><C-n><C-w>]], bind_opts)
		end,
	})

	-- set keymaps for terms
	api.nvim_set_keymap(
		"n",
		"<leader>tn",
		"<cmd>SpawnNodeTerminal<CR>",
		{ noremap = true, silent = true, desc = "Open Node Terminal" }
	)

	api.nvim_set_keymap(
		"n",
		"<leader>tb",
		"<cmd> SpawnBtopTerminal <CR>",
		{ noremap = true, silent = true, desc = "Open Btop" }
	)
end

return M

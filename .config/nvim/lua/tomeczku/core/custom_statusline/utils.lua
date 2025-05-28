-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞
--
local M = {}

-- determine if window is an active one
---@return boolean
M.is_activewin = function()
	return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

-- bufnr related to the statusline
---@return integer
M.stbufnr = function()
	return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

-- determine if in a narrow split window (at least half the screen)
---@return boolean
M.is_narrow_split = function()
	return vim.api.nvim_win_get_width(vim.g.statusline_winid or 0) <= 95
end

---@return table
M.path_formatter = function(root_sep, path_end_sep)
	--LOCAL HELPERS:

	-- reformat to 'fish' shell style
	---@param path string
	---@return string
	local function fishify_path(path)
		local dirs = {}
		for part in string.gmatch(path, "[^/]+") do
			table.insert(dirs, part)
		end

		local shortened_dirs = {}
		for i = 1, #dirs - 1 do
			table.insert(shortened_dirs, dirs[i]:sub(1, 1))
		end
		table.insert(shortened_dirs, dirs[#dirs])

		return table.concat(shortened_dirs, "/")
	end

	-- VARS
	local project_root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local relative_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
	local file_name = vim.fn.fnamemodify(relative_path, ":t")
	-- CONDITIONAL FORMATTING
	--
	-- if path itself is particularly long then reformat it
	-- in the style used in fish shell truncation of parent dirs names

	if #relative_path > 40 then
		relative_path = fishify_path(relative_path)
	end

	-- if screen split then just display name instead of full or truncated path
	if M.is_narrow_split() then
		relative_path = file_name
	end

	-- if in term adjust string elements as no path/filename is being displayed
	if vim.api.nvim_get_mode().mode == "t" then
		root_sep = "%#St_TerminalMode_Root_Sep#█"
		path_end_sep = ""
		return { root = "", path = "", root_sep = root_sep, path_end_sep = path_end_sep }
	end

	if vim.api.nvim_get_mode().mode == "nt" then
		root_sep = "%#St_NTerminalMode_Root_Sep#█"
		path_end_sep = ""
		return { root = "", path = "", root_sep = root_sep, path_end_sep = path_end_sep }
	end

	local root = " " .. project_root .. " %#St_Root_Sep_Right#"
	if vim.bo.filetype == "oil" then
		root = " 󰏇  %#St_Root_Sep_Right#"
		relative_path = " Oil "
	end

	return {
		root = root,
		path = relative_path,
		root_sep = root_sep,
		path_end_sep = path_end_sep,
	}
end

-- NOTE: helper for picking the lsp to display consistently
-- prioritize dsplaying the lsp client associated with the filetype most directly

---@param bufnr integer
---@diagnostic disable-next-line: undefined-doc-name
---@param clients table<vim.lsp.Client>?
---@return table?
local setMainClient = function(bufnr, clients)
	if not clients or next(clients) == nil then
		return nil
	end

	local buf_filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
	if buf_filetype == "markdown" then
		return { clients[1], buf_filetype }
	end

	local clients_to_skip = {
		"harper-ls",
		"copilot",
		"emmet-language-server",
	}

	for _, client in pairs(clients) do
		if vim.tbl_contains(clients_to_skip, client.name) then
			goto continue
		end
		-- case as simple as braindead lsp name contains the filetype straight up return this client
		if string.find(client.name:lower(), buf_filetype:lower()) then
			return { client, buf_filetype }
		-- fallback 1: if any clients has filetype in supported filetypes then grab first that matches
		elseif client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_filetype) then
			-- ok damn special case stupid frameworks they make me look bad!
			if buf_filetype == "blade" then
				buf_filetype = "php"
			end
			return { client, buf_filetype }
		end
		::continue::
	end
	-- as a stupid last fallback return just first client attached to buf
	return { clients[1], buf_filetype }
end

local superscript_map = {
	["0"] = "⁰",
	["1"] = "¹",
	["2"] = "²",
	["3"] = "³",
	["4"] = "⁴",
	["5"] = "⁵",
	["6"] = "⁶",
	["7"] = "⁷",
	["8"] = "⁸",
	["9"] = "⁹",
}

--@param value integer
--@return string
M.intToSuperscript = function(value)
	local str = tostring(value)
	return str:gsub("[0-9]", superscript_map)
end

---@param bufnr integer
---@diagnostic disable-next-line: undefined-doc-name
---@param clients table<vim.lsp.Client>?
---@return table?
M.makeLspString = function(bufnr, clients)
	-- get the primary lsp attached to the buf
	local main_client_data = setMainClient(bufnr, clients)
	if not main_client_data then
		return nil
	end
	local additional_lsps_count = ""
	if #clients > 1 then
		additional_lsps_count = "⁺" .. M.intToSuperscript(#clients - 1)
	end

	-- get icons per filetype or provide fallback safely
	local devicons = require("nvim-web-devicons")
	local ok, icon = pcall(devicons.get_icon_by_filetype, main_client_data[2])
	if not ok or icon == nil or #icon > 3 then
		icon = ""
	end
	icon = icon .. " "
	if #main_client_data[1].name > 10 then
		return { name = main_client_data[2] .. "-lsp" .. additional_lsps_count, icon = icon }
	else
		return { name = main_client_data[1].name .. additional_lsps_count, icon = icon }
	end
end

return M

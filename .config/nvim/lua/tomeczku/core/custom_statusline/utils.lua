-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞
--
local M = {}

-- determine if window is an active one
M.is_activewin = function()
	return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

-- bufnr related to the statusline
M.stbufnr = function()
	return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

-- determine if in a narrow split window (at least half the screen)
M.is_narrow_split = function()
	return vim.api.nvim_win_get_width(vim.g.statusline_winid or 0) <= 95
end

M.path_formatter = function(root_sep, path_end_sep)
	--LOCAL HELPERS:
	-- reformat to "fish shell style
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
		root_sep = "%#St_TerminalMode_Root_Sep#"
		path_end_sep = ""
		return { root = "", path = "", root_sep = root_sep, path_end_sep = path_end_sep }
	end

	if vim.api.nvim_get_mode().mode == "nt" then
		root_sep = "%#St_NTerminalMode_Root_Sep#"
		path_end_sep = ""
		return { root = "", path = "", root_sep = root_sep, path_end_sep = path_end_sep }
	end

	local root = "  " .. project_root .. " %#St_Root_Sep_Right#"
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

M.setLspStringComponents = function(client, cname)
	if client.attached_buffers[vim.fn.winbufnr(vim.g.statusline_winid)] and cname ~= "null-ls" then
		if cname == "lua_ls" then
			return { name = cname, icon = " " }
		elseif
			(cname == "ts_ls" or cname == "cssmodules_ls" or cname == "tailwindcss")
			and (vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript")
		then
			return { name = "ts_ls", icon = "󰛦 " }
		elseif (cname == "astro" or cname == "tailwindcss" or cname == "ts_ls") and vim.bo.filetype == "astro" then
			return { name = "astro-ls", icon = " " }
		elseif cname == "bashls" then
			return { name = cname, icon = " " }
		elseif
			(cname == "emmet_language_server" or cname == "html" or cname == "tailwindcss")
			and vim.bo.filetype == "html"
		then
			return { name = "html-lsp", icon = "󰌝 " }
		elseif
			(cname == "emmet_language_server" or cname == "cssls" or cname == "tailwindcss")
			and (
				vim.bo.filetype == "css"
				or vim.bo.filetype == "scss"
				or vim.bo.filetype == "less"
				or vim.bo.filetype == "sass"
				or vim.bo.filetype == "less"
			)
		then
			return { name = "cssls", icon = " " }
		elseif cname == "jsonls" and vim.bo.filetype == "json" then
			return { name = "jsonls", icon = "󰘦 " }
		elseif cname == "hyprls" and vim.bo.filetype == "hyprlang" then
			return { name = "hyprls", icon = " " }
		elseif cname == "gopls" then
			return { name = "gopls", icon = "󰟓 " }
		-- elseif (cname == "intelephese" or cname == "tailwindcss") and vim.bo.filetype == "php" then
		-- 	return { name = "intelephense", icon = " " }
		elseif (cname == "phpactor" or cname == "tailwindcss") and vim.bo.filetype == "php" then
			return { name = "phpactor", icon = " " }
		elseif cname == "omnisharp" then
			return { name = "omnisharp", icon = " " }
		elseif cname == "lemminx" then
			return { name = cname, icon = "󰗀 " }
		elseif cname == "yamlls" then
			return { name = cname, icon = " " }
		elseif cname == "docker_compose_language_service" then
			return { name = "docker-compose-ls", icon = " " }
		else
			return { name = cname, icon = "󰧑 " }
		end
	end
	return nil
end
return M

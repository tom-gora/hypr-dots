local augroup = function(group)
	return vim.api.nvim_create_augroup(group, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- for highliting the text on yank
autocmd("TextYankPost", {
	group = augroup("YankHighlight"),
	callback = function()
		vim.highlight.on_yank({
			timeout = 200,
			higroup = "MatchWord",
		})
	end,
	pattern = "*",
})

-- in windows at least half the screen width open help as vertical float with wrap
vim.api.nvim_create_autocmd({ "WinNew", "BufEnter" }, {
	group = augroup("UiHelpers"),
	callback = function()
		if vim.bo.buftype == "help" or vim.bo.filetype == "man" then
			local origin_win = vim.fn.win_getid(vim.fn.winnr("#"))
			local origin_buf = vim.api.nvim_win_get_buf(origin_win)
			-- NOTE: this is because I still want it to split vertically when I have window
			-- taking half the screen in a tiler and don't need to adhere to 80 columns
			-- of traditional terminal width
			local origin_textwidth = vim.bo[origin_buf].textwidth
			if origin_textwidth == 0 then
				origin_textwidth = 50
			end
			if vim.api.nvim_win_get_width(origin_win) >= origin_textwidth + 50 then
				local help_buf = vim.fn.bufnr()
				local bufhidden = vim.bo.bufhidden
				vim.bo.bufhidden = "hide"

				local old_help_win = vim.api.nvim_get_current_win()
				vim.api.nvim_set_current_win(origin_win)
				vim.api.nvim_win_close(old_help_win, false)

				vim.cmd("vsplit")
				-- set my own dybamic width to the split
				local help_win_width = math.floor(vim.o.columns * 0.45)
				local help_win_height = math.floor(vim.o.lines * 0.92)
				local offset = vim.o.columns - (help_win_width + 3)
				-- vim.cmd("vert resize " .. help_win_width)
				vim.wo.wrap = true
				vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
					relative = "editor",
					width = help_win_width,
					height = help_win_height,
					row = 1,
					col = offset,
					border = "rounded",
					title = "   RTFM ",
					title_pos = "left",
					style = "minimal",
				})
				vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf)
				vim.bo.bufhidden = bufhidden
			end
		end
	end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	group = augroup("AstroLSP"),
-- 	pattern = { "*.astro" },
-- 	callback = function()
-- 		local diagnostics_data = vim.diagnostic.get()
-- 		local cursor_col, cursor_line
-- 		for _, diagnostic in pairs(diagnostics_data) do
-- 			if string.find(diagnostic.message, "Cannot find name ") then
-- 				cursor_col = diagnostic.col
-- 				cursor_line = diagnostic.end_lnum + 1
-- 				print("found a missing import")
-- 				vim.api.nvim_win_set_cursor(0, { cursor_line, cursor_col })
-- 				vim.lsp.buf.code_action({
-- 					context = { diagnostics = diagnostic, only = { "source.organizeImports" } },
-- 					apply = true,
-- 				})
-- 			end
-- 		end
-- 	end,
-- })

-- garbage below
--
-- autocmd("LspAttach", {
-- 	group = augroup("AstroLSP"),
-- 	once = true,
-- 	callback = function(args)
-- 		if not (args.data and args.data.client_id) then
-- 			return
-- 		end
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
-- 		if client.name == "astro" then
-- 			autocmd("FileWritePre", {
-- 				group = augroup("AstroLSP"),
-- 				callback = function()
-- 					print("text changed in astro")
-- 					local diags_count = vim.diagnostic.count(0)
-- 					if diags_count <= 0 then
-- 						return
-- 					end
-- 					local bufnr = vim.api.nvim_get_current_buf()
-- 					local diags = vim.diagnostic.get(bufnr)
-- 					vim.print(diags)
-- 					for _, diag in ipairs(diags) do
-- 						if diag.message ~= "" then
-- 							print("got some diagnostics")
-- 							local params = vim.lsp.util.make_range_params()
--
-- 							params.context = {
-- 								triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
-- 								diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
-- 							}
--
-- 							local actions = vim.lsp.buf_request(
-- 								bufnr,
-- 								"textDocument/codeAction",
-- 								params,
-- 								function(error, results, context, config)
-- 									-- results is an array of lsp.CodeAction
-- 								end
-- 							)
-- 							vim.print(actions)
-- 						end
-- 					end
-- 				end,
-- 			})
-- 		end
-- 	end,
-- 	-- local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf(), name = "astro" })
-- 	-- if #clients > 0 then
-- 	-- 	vim.print(clients)
-- 	-- 	-- autocmd("InsertChange", {
-- 	-- 	print("Astro LS attached")
-- 	-- end
-- })

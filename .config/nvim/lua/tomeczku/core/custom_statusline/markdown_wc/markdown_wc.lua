local api = vim.api

local buffer_timers = {}

-- debounce delay in milliseconds
local DEBOUNCE_MS = 1000

-- helper to strip html tags of my markdown string
--
--- @param lines table The input Markdown text.
--- @return string Stripped down raw string of text from markdown
local function stripMarkdown(lines)
	if not lines then
		return ""
	end

	local stripped_lines = {}
	local inside_diagram_block = false

	for _, line in ipairs(lines) do
		-- Normalize newlines
		line = string.gsub(line, "[\r\n]", " ")

		if inside_diagram_block then
			if string.match(line, "^```") then
				inside_diagram_block = false -- end of diagram block
			end
			-- skip all lines inside diagram block
			goto continue
		end

		-- Start of a code block
		if string.match(line, "^```") then
			if string.match(line, "mermaid") or string.match(line, "plantuml") then
				inside_diagram_block = true
				goto continue
			else
				-- just remove the ``` line but keep the code inside
				goto continue
			end
		end

		-- horizontal dividers
		line = string.gsub(line, "^%s*[-]+%s*$", "")
		line = string.gsub(line, "^%s*_*%s*$", "")
		line = string.gsub(line, "^%s***%s*$", "")

		if line ~= "" and not string.match(line, "^%s*$") then
			-- headers
			line = string.gsub(line, "^#+%s*", " ")
			-- blockquotes
			line = string.gsub(line, "^>+%s*", " ")
			-- list markers (unordered)
			line = string.gsub(line, "^%s*[-*+]%s+", " ")
			-- list markers (ordered)
			line = string.gsub(line, "^%s*%d+%.%s+", " ")

			if line ~= "" and not string.match(line, "^%s*$") then
				table.insert(stripped_lines, line)
			end
		end

		::continue::
	end

	-- concat results into clean lines
	local text = table.concat(stripped_lines, "\n")

	-- remove any html markup
	text = string.gsub(text, "<script%s*[^>]*>[%s%S]-</script%s*>", " ")
	text = string.gsub(text, "<style%s*[^>]*>[%s%S]-</style%s*>", " ")
	text = string.gsub(text, "<!--[%s%S]- -->", " ")
	text = string.gsub(text, "<[^>]*>", " ")
	text = string.gsub(text, "%]%([^)]*%)", " ")

	return text
end

--  helper resetting any existing timers
local clearTimers = function(bufnr)
	if buffer_timers[bufnr] then
		buffer_timers[bufnr]:close()
		buffer_timers[bufnr] = nil
	end
end

--  recalculate the wordcount
local function calcWordCount(bufnr)
	if not api.nvim_buf_is_valid(bufnr) then
		return
	end

	-- futher check if not markdown buf
	if api.nvim_get_option_value("filetype", { buf = bufnr }) ~= "markdown" then
		vim.b[bufnr].markdown_word_count = nil
		return
	end

	local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
	-- call tag stripping helper ahead of running count
	local text = stripMarkdown(lines)
	-- vim.notify(text)

	local word_count = 0
	for word in string.gmatch(text, "%S+") do
		if word ~= "" then
			-- strip apostrophes as those add unwanted count inconsistend
			-- with standard counters like in MS Word on popular online solutions
			word = string.gsub(word, "'s", "")
			if string.match(word, "%w") then
				word_count = word_count + 1
			end
		end
	end

	-- store the wordcount locally on the buf
	vim.b[bufnr].markdown_word_count = word_count

	-- update statusline strings per window
	for _, winid in ipairs(api.nvim_list_wins()) do
		if api.nvim_win_get_buf(winid) == bufnr then
			local current_stl = api.nvim_get_option_value("statusline", { win = winid })
			api.nvim_set_option_value("statusline", current_stl, { win = winid })
		end
	end
end

local function scheduleWordcountUpdate(bufnr)
	if not api.nvim_buf_is_valid(bufnr) then
		return
	end

	clearTimers(bufnr)

	-- set up new one
	buffer_timers[bufnr] = vim.uv.new_timer()
	buffer_timers[bufnr]:start(
		DEBOUNCE_MS,
		0,
		vim.schedule_wrap(function()
			calcWordCount(bufnr)
			clearTimers(bufnr)
		end)
	)
end

-- set listeners up
local function attachBuf(bufnr)
	if vim.b[bufnr].markdown_wc_attached or api.nvim_get_option_value("filetype", { buf = bufnr }) ~= "markdown" then
		return
	end

	-- -1 displays "loading" state
	vim.b[bufnr].markdown_word_count = -1
	scheduleWordcountUpdate(bufnr)

	local augroup = api.nvim_create_augroup("MarkdownWordCounter_" .. bufnr, { clear = true })

	-- update of buf text change autocmd
	api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		group = augroup,
		buffer = bufnr,
		callback = function(args)
			scheduleWordcountUpdate(args.buf)
		end,
	})

	-- cleanup autocmd
	api.nvim_create_autocmd({ "BufLeave", "BufDelete" }, {
		group = augroup,
		buffer = bufnr,
		callback = function(args)
			clearTimers(args.buf)
		end,
	})

	vim.b[bufnr].markdown_wc_attached = true
end

-- setup func exposed
local M = {}
M.setup = function()
	attachBuf(api.nvim_get_current_buf())
end

return M

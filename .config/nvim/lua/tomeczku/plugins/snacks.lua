if vim.g.vscode then
	return
end

local M, opts, my_layouts

my_layouts = {
	["buffers-custom"] = {
		preset = "dropdown",
		preview = false,
		reverse = true,
		layout = {
			backdrop = true,
			row = 0.3,
			width = 0.3,
			min_width = 70,
			height = 0.3,
			border = "none",
			box = "vertical",
			{
				box = "vertical",
				border = "solid",
				title = "{title} {live} {flags}",
				title_pos = "right",
				{ win = "list", border = "solid" },
				{ win = "input", height = 1, border = "none" },
			},
		},
	},
	["borderless-ivy"] = {
		layout = {
			box = "vertical",
			backdrop = false,
			row = -1,
			width = 0,
			height = 0.3,
			border = "solid",
			title = " {title} {live} {flags}",
			title_pos = "right",
			{ win = "input", height = 1, border = "none" },
			{
				box = "horizontal",
				{ win = "list", border = "solid" },
				{ win = "preview", title = "{preview}", title_pos = "right", width = 0.6, border = "solid" },
			},
		},
	},
	["borderless-right"] = {
		preset = "sidebar",
		preview = "main",
		layout = {
			backdrop = false,
			width = 40,
			min_width = 40,
			height = 0,
			position = "right",
			border = "none",
			box = "vertical",
			{
				win = "input",
				height = 1,
				border = "solid",
				title = "{title} {live} {flags}",
				title_pos = "right",
			},
			{ win = "list", border = "none" },
			{ win = "preview", title = "{preview}", title_pos = "right", height = 0.4, border = "solid" },
		},
	},
}

opts = {
	styles = { lazygit = { border = "solid" } },
	-- only enable selected
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = false },
	indent = { enabled = true },
	input = { enabled = false },
	lazygit = { enabled = true, opts = {
		style = "lazygit",
	} },
	picker = {
		enabled = true,
		prompt = " ",
		layouts = {
			["buffers-custom"] = my_layouts["buffers-custom"],
			["borderless-ivy"] = my_layouts["borderless-ivy"],
			["borderless-right"] = my_layouts["borderless-right"],
		},
		sources = {
			buffers = {
				layout = "buffers-custom",
			},
			-- NOTE: Simple test on how to configure a picker
			-- {
			-- idea1 - model picker for aider and other tools
			-- steps:
			-- # on startup try and curl https://openrouter.ai/api/v1/models if valid json received store in vim.fn.stdpath("state")
			-- # !!! parse once while caching to not perform this on and on (lua? fast enough? qf? better for fast json transofrmS?) to only store names
			-- SCRATCH THAT. since they don't provide a way to pull sorted data from api some web scraping is very much needed. which IS a pain because the fucking
			-- openrouter page is nothing but a div soup with a bunch of tailwind classes and literally  I think the sole thing you can target with CSS selectors are anchors with regex matchers on hrefs??
			-- OK scratch the drama. worst case scenario just grab last div of section.main-content-container which is a div table!
			-- even better. I only need links because each has a form that after removing .ai TLD bit and initial / turns into valid model name for aider :)
			-- so again:
			-- do this quick scrape (can lua parse html? dunno) since grabbing monthly top [i.e. https://openrouter.ai/rankings/programming?view=month] it can be done rarely
			-- monthly or weekly. so could have a separate package in like go or shit that scrapes and stores cache for nvim
			-- anyway obtain list of top models, parse the json from listing api to match with obtained scraped strings
			-- for each grab metadata and then store for picker to use
			--
			--
			--}
			--
			-- messages = {
			-- 	title = "names",
			-- 	confirm = { "copy", "close" },
			-- 	format = "text",
			-- 	layout = "buffers-custom",
			-- 	finder = function(opts, ctx)
			-- 		local mock_names = {
			-- 			{ text = "Alice" },
			-- 			{ text = "Bob" },
			-- 			{ text = "Charlie" },
			-- 			{ text = "Diana" },
			-- 			{ text = "Edward" },
			-- 			{ text = "Fiona" },
			-- 			{ text = "George" },
			-- 			{ text = "Hannah" },
			-- 			{ text = "Ivy" },
			-- 			{ text = "Jack" },
			-- 			{ text = "Karen" },
			-- 			{ text = "Liam" },
			-- 			{ text = "Mia" },
			-- 			{ text = "Noah" },
			-- 			{ text = "Olivia" },
			-- 			{ text = "Peter" },
			-- 			{ text = "Quinn" },
			-- 			{ text = "Rachel" },
			-- 			{ text = "Sam" },
			-- 			{ text = "Tina" },
			-- 		}
			-- 		return mock_names
			-- 	end,
			-- },
		},
		layout = {
			cycle = false,
			preset = function()
				return vim.o.columns >= 106 and "borderless-ivy" or "borderless-right"
			end,
		},
		matcher = { freecency = true },
		win = {
			input = {
				keys = {
					["<c-n>"] = { "history_forward", mode = { "i", "n" } },
					["<c-p>"] = { "history_back", mode = { "i", "n" } },
					["<c-c>"] = { "cancel", mode = "i" },
					["<CR>"] = { "confirm", mode = { "n", "i" } },
					["<c-a>"] = { "confirm", mode = { "n", "i" } },
					["<Esc>"] = "cancel",
					["<a-k>"] = { "select_and_prev", mode = { "i", "n" } },
					["<a-j>"] = { "select_and_next", mode = { "i", "n" } },
					["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
					["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
					["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
					["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
					["<a-a>"] = { "select_all", mode = { "n", "i" } },
					["<c-f>"] = { "preview_scroll_up", mode = { "i", "n" } },
					["<c-b>"] = { "preview_scroll_down", mode = { "i", "n" } },
					["<c-j>"] = { "list_down", mode = { "i", "n" } },
					["<c-k>"] = { "list_up", mode = { "i", "n" } },
					["<c-q>"] = { "qflist", mode = { "i", "n" } },
					["?"] = "toggle_help_input",
					["G"] = "list_bottom",
					["gg"] = "list_top",
					["j"] = "list_down",
					["k"] = "list_up",
					-- disabled default feature creeps ;]
					["/"] = false,
					["<c-g>"] = false, -- { "toggle_live", mode = { "i", "n" } },
					["<C-Down>"] = false,
					["<C-Up>"] = false,
					["<S-CR>"] = false,
					["<C-w>"] = false,
					["<Down>"] = false,
					["<S-Tab>"] = false,
					["<Tab>"] = false,
					["<Up>"] = false,
					["<a-d>"] = false, -- ? { "inspect", mode = { "n", "i" } },
					["<a-f>"] = false, -- { "toggle_follow", mode = { "i", "n" } },
					["<a-w>"] = false,
					["<c-d>"] = false,
					["<c-s>"] = false, -- { "edit_split", mode = { "i", "n" } },
					["<c-u>"] = false,
					["<c-v>"] = false, -- { "edit_vsplit", mode = { "i", "n" } },
					["<c-r>#"] = false, -- { "insert_alt", mode = "i" },
					["<c-r>%"] = false, -- { "insert_filename", mode = "i" },
					["<c-r><c-a>"] = false, -- { "insert_cWORD", mode = "i" },
					["<c-r><c-f>"] = false, -- { "insert_file", mode = "i" },
					["<c-r><c-l>"] = false, -- { "insert_line", mode = "i" },
					["<c-r><c-p>"] = false, -- { "insert_file_full", mode = "i" },
					["<c-r><c-w>"] = false, -- { "insert_cword", mode = "i" },
					["<c-w>H"] = false, -- "layout_right",
					["<c-w>J"] = false, -- "layout_bottom",
					["<c-w>K"] = false, -- "layout_top",
					["<c-w>L"] = false, -- "layout_right",
					["q"] = false,
				},
			},
		},
	},
	notifier = {
		enabled = true,
		style = function(buf, notif, ctx)
			-- -- override the minimal style to do minimal WITH border
			-- ctx.opts.border = "solid"
			local whl = ctx.opts.wo.winhighlight
			ctx.opts.wo.winhighlight = whl:gsub(ctx.hl.msg, "SnacksNotifierMinimal")
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(notif.msg, "\n"))
			vim.api.nvim_buf_set_extmark(buf, ctx.ns, 0, 0, {
				virt_text = { { notif.icon, ctx.hl.icon } },
				virt_text_pos = "right_align",
			})
		end,
		top_down = false,
	},
	quickfile = { enabled = true },
	scope = { enabled = false },
	scroll = { enabled = false },
	statuscolumn = { enabled = false },
	terminal = { enabled = true },
	words = { enabled = false },
	zen = {
		enabled = true,
		toggles = {
			dim = false,
			git_signs = true,
		},
		show = {
			statusline = false,
			tabline = false,
		},
	},
}

M = {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = opts,
}

return M

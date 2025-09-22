local localHelpers = {
	-- bootstrap spellfiles if not existing
	setupSpellfiles = function()
		local spell_dir = vim.fn.stdpath("data") .. "/site/spell"
		if vim.fn.isdirectory(spell_dir) == 0 then
			vim.fn.mkdir(spell_dir, "p")
		end
		local spellfile = spell_dir .. "/en.utf-8.add"

		local spellfile_spl = spellfile .. ".spl"
		if vim.fn.filereadable(spellfile) == 0 then
			local ok, err = pcall(function()
				local file = io.open(spellfile, "w")
				if not file or file == nil then
					return
				end
				file:write("# Vim spellfile\n# Added words will be placed below this line\n")
				file:close()
			end)

			if not ok then
				vim.notify("Failed to create spellfile: " .. err, vim.log.levels.WARN)
			end
		end

		local spellfile_spl = spellfile .. ".spl"
		if vim.fn.filereadable(spellfile) == 1 and vim.fn.filereadable(spellfile_spl) == 0 then
			vim.cmd("mkspell! " .. spellfile)
		end
		return spellfile
	end,
	--
	-- function formatting folds
	foldText = function()
		local line = vim.fn.getline(vim.v.foldstart)
		local numOfLines = vim.v.foldend - vim.v.foldstart
		local fillCount = vim.fn.winwidth("%") - #line - #tostring(numOfLines) - 14
		return line .. "  " .. string.rep(".", fillCount) .. " (" .. numOfLines .. " L)"
	end,
}

local opt = vim.opt
-- map the leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.editorconfig = true

opt.cursorline = true
-- declare encoding
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- netrw tree
vim.cmd("let g:netrw_liststyle = 3")

-- set my line numbers to relative
opt.number = true
opt.relativenumber = true
opt.numberwidth = 1

-- sync + reg to system clipboard
opt.clipboard:prepend("unnamedplus")

-- all the indentation and lines stuff
opt.wrap = false
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- pretty colours
opt.termguicolors = true
opt.background = "dark"
opt.hlsearch = true

-- splits stuff
opt.inccommand = "split"
opt.splitbelow = true
opt.splitright = true

-- cmdline tweaks
opt.ignorecase = true
opt.smartcase = true
opt.cmdheight = 0

-- text editor tweaks
opt.virtualedit = "block"
opt.scrolloff = 999
opt.cursorline = true
opt.signcolumn = "yes"

-- UI tweaks
opt.showtabline = 0
opt.fillchars = {
	eob = "˜",
	horiz = "─",
	horizup = "┴",
	horizdown = "┬",
	vert = "│",
	vertleft = "┤",
	vertright = "├",
	verthoriz = "┼",
	fold = " ",
	-- tab = " ",
	-- trail = " ",
}

-- globally set border for floats
opt.winborder = "solid"

-- blinky cursor
vim.cmd(
	"set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait1000-blinkoff600-blinkon600-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
)

-- enable undo file
opt.undofile = true
-- global statusline
opt.laststatus = 3
-- disable mouse
opt.mouse = ""
-- auto read files on change
opt.autoread = true
-- folding
opt.foldenable = true
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldmethod = "expr"
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
vim.wo.foldnestmax = 5
vim.wo.foldminlines = 3

opt.foldtext = localHelpers.foldText()

opt.spelllang = "en_gb"
opt.spellfile = localHelpers.setupSpellfiles()

-- set treshold for filesize at which to disable features
_G.thick_boi_file = 0.005

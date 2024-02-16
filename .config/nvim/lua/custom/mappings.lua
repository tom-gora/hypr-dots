---@diagnostic disable: inject-field
-- Remaps as per nvChad docs; Which-Key group names defined in wk config file

---@type MappingsTable
local M = {}
local general_opts = { nnoremap = true, silent = true }
local ignore = "which_key_ignore"

M.general = {
  n = {

    ---------------------------------[ LSP info hover trigger ]
    ["<a-cr>"] = {
      "<cmd>lua ToggleFloatDoc()<cr>",
      "",
      general_opts,
    },
    ---------------------------------[ position the cursor after pasted in text]
    ["p"] = {
      "gp",
      "",
      general_opts,
    },
    ----------------------[ fix polluting clipboard with non cutting operations]
    ["c"] = {
      '"_c',
      "",
      general_opts,
    },

    ["x"] = {
      '"_x',
      "",
      general_opts,
    },

    ["d"] = {
      '"_d',
      "",
      general_opts,
    },
    ----------------------------------------------------[ Toggle comment line ]
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "󰿠 Toggle comment",
      general_opts,
    },
    ----------------------------------------[ Quick linewise visual selection ]
    ["<leader><leader>"] = {
      "V",
      "󰘤 Select line block mode",
    },
    -------------------------------------------[ Select entire buffer content ]
    ["<leader>a"] = {
      "ggVG",
      "󰩭 Select All",
      general_opts,
    },
    -----------------------------------------------[ Quick leader driven save ]
    ["<leader>w"] = {
      "<cmd>w<cr>",
      " Write to file",
      general_opts,
    },
    ---------------------------------------------------------[ Quitting group ]
    ["<leader>qq"] = {
      "<cmd>q<cr>",
      "QUIT neovim",
      general_opts,
    },

    ["<leader>qQ"] = {
      "<cmd>q!<cr>",
      "QUIT neovim without saving",
      general_opts,
    },

    ["<leader>qw"] = {
      "<cmd>wq<cr>",
      "WRITE and QUIT neovim",
      general_opts,
    },

    ["<leader>qc"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close CURRENT buffer",
      general_opts,
    },

    ["<leader>qo"] = {
      "<cmd>%bdelete|edit #|normal`<cr>",
      "Close all OTHER buffers ",
      general_opts,
    },
    -------------------------------------------------------------[ Find group ]
    ["<leader>fe"] = {
      "<cmd>Telescope file_browser <CR>",
      "Telescope file EXPLORER",
      general_opts,
    },

    ["<leader>ff"] = {
      "<cmd>Telescope find_files <CR>",
      "Telescope FILES",
      general_opts,
    },

    ["<leader>fa"] = {
      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>",
      "Telescope ALL FILES (hidden etc)",
      general_opts,
    },

    ["<leader>fd"] = {
      "<cmd>Telescope live_grep <CR>",
      "Telescope live grep the root DIRECTORY",
      general_opts,
    },

    ["<leader>fw"] = {
      "<cmd>Telescope current_buffer_fuzzy_find <CR>",
      "Telescope live grep THIS BUFFER",
      general_opts,
    },

    ["<leader>fr"] = {
      "<cmd>Telescope oldfiles <CR>",
      "Telescope find RECENT FILES",
      general_opts,
    },

    ["<leader>ft"] = {
      "<cmd>Telescope grep_string <CR>",
      "Telescope live grep THIS WORD (under cursor)",
      general_opts,
    },

    ["<leader>fp"] = {
      "<cmd>Telescope pickers <CR>",
      "Telescope find recently used pickers",
      general_opts,
    },

    ----------------------------------------------------------[ Yanking group ]
    ["<leader>ya"] = {
      "<cmd>%y+ <CR>",
      "Yank ALL lines",
      general_opts,
    },

    ["<leader>yp"] = {
      function()
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
        vim.fn.setreg("+", path)
        vim.notify(
          path,
          vim.log.levels.INFO,
          { title = "Yanked relative path" }
        )
      end,
      "Yank RELATIVE path",
      general_opts,
    },

    ["<leader>yP"] = {
      function()
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
        vim.fn.setreg("+", path)
        vim.notify(
          path,
          vim.log.levels.INFO,
          { title = "Yanked absolute path" }
        )
      end,
      "Yank ABSOLUTE path",
      general_opts,
    },

    ["<leader>yf"] = {
      function()
        local fileName = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
        vim.fn.setreg("+", fileName)
        vim.notify(
          fileName,
          vim.log.levels.INFO,
          { title = "Yanked file name only" }
        )
      end,
      "Yank FILE NAME with extension",
      general_opts,
    },

    ["<leader>yF"] = {
      function()
        local fileNameNoExt =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")
        vim.fn.setreg("+", fileNameNoExt)
        vim.notify(
          fileNameNoExt,
          vim.log.levels.INFO,
          { title = "Yanked file name without extension" }
        )
      end,
      "Yank FILE NAME without extension",
      general_opts,
    },
    -----------------------------------------------[ Search and replace group ]
    ["<leader>ro"] = {
      "<CMD>SearchReplaceSingleBufferOpen<CR>",
      "OPEN replace",
      general_opts,
    },

    ["<leader>rw"] = {
      "<CMD>SearchReplaceSingleBufferCWord<CR>",
      "Replace WORD under cursor",
      general_opts,
    },

    ["<leader>rg"] = {
      "<CMD>SearchReplaceSingleBufferCWORD<CR>",
      "Replace GREEDY WORD under cursor",
      general_opts,
    },
    ["<leader>re"] = {
      "<CMD>SearchReplaceSingleBufferCExpr<CR>",
      "Replace EXPRESSION under cursor",
      general_opts,
    },

    ["<leader>rbo"] = {
      "<CMD>SearchReplaceMultiBufferOpen<CR>",
      "OPEN multiBUFFER replace",
      general_opts,
    },

    ["<leader>rbw"] = {
      "<CMD>SearchReplaceMultiBufferCWord<CR>",
      "Replace multiBUFFER WORD under cursor",
      general_opts,
    },
    ["<leader>rbg"] = {
      "<CMD>SearchReplaceMultiBufferCWORD<CR>",
      "Replace multiBUFFER GREEDY WORD under cursor",
      general_opts,
    },

    ["<leader>rbe"] = {
      "<CMD>SearchReplaceMultiBufferCExpr<CR>",
      "Replace multiBUFFER EXPRESSION under cursor",
      general_opts,
    },
    ----------------------------------------------------------[ Terminal group]
    ["<leader>tf"] = {
      "<cmd>ToggleTerm direction=float<cr>",
      "Toggle floating TERM",
      general_opts,
    },

    ["<leader>th"] = {
      "<cmd>ToggleTerm direction=horizontal<cr>",
      "Toggle horizontal TERM",
      general_opts,
    },

    ["<leader>tv"] = {
      "<cmd>ToggleTerm direction=vertical<cr>",
      "Toggle vertical TERM",
      general_opts,
    },
    ----------------------------------------------------[ Code functionalities]
    ["<leader>cli"] = {
      "<cmd>LspInfo<cr>",
      "LSP INFO",
      general_opts,
    },

    ["<leader>clr"] = {
      "<cmd>LspInfo<cr>",
      "Restart LSP",
      general_opts,
    },

    ["<leader>cf"] = {
      "<cmd>ConformFormat<cr>",
      "FORMAT with Conform",
      general_opts,
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "Code ACTIONS from LSP",
      general_opts,
    },

    ["<leader>cs"] = {
      "<cmd>AerialToggle<cr>",
      "Inspect SYMBOLS with Aerial",
      general_opts,
    },

    ["<leader>cc"] = {
      "<cmd> Telescope spell_suggest <CR>",
      "Spelling CORRECTIONS",
      general_opts,
    },

    ["<leader>cu"] = {
      "<cmd>Telescope undo<CR>",
      "View UNDO tree",
      general_opts,
    },

    ["<leader>cx"] = {
      "<cmd>lua SnipRunFlowSnippet()<CR>",
      "Execute SNIPPET with SnipRun",
      general_opts,
    },

    ["<leader>cX"] = {
      "<cmd>lua SnipRunFlowFile()<CR>",
      "Execute FILE with SnipRun",
      general_opts,
    },

    ["<leader>cv"] = {
      "<cmd>SnipClose<CR>",
      "Close SnipRun",
      general_opts,
    },

    ----------------------------------------------------------[ Help group XD ]
    ["<leader>hh"] = {
      "<cmd>NvCheatsheet<CR>",
      "Mappings cheatsheet HELP",
      general_opts,
    },

    ["<leader>hf"] = {
      "<cmd>Telescope help_tags <CR>",
      "FIND in help",
      general_opts,
    },
    ----------------------------------------------------------[ NeoVim group]
    ["<leader>ns"] = {
      "<cmd>lua Clear_swap()<CR>",
      "Clear the contents of SWAP directory",
      general_opts,
    },

    ["<leader>nl"] = {
      "<cmd>Lazy<CR>",
      "Open LAZY",
      general_opts,
    },

    ["<leader>nm"] = {
      "<cmd>Mason<CR>",
      "Open MASON",
      general_opts,
    },

    ["<leader>nc"] = {
      "<cmd>checkhealth<CR>",
      "Do CHECKHEALTH",
      general_opts,
    },

    ["<leader>nt"] = {
      "<cmd> Telescope themes <CR>",
      "Change THEMES",
      general_opts,
    },
    ["<leader>nh"] = {
      "<cmd> Telescope highlights <CR>",
      "Look up HIGHLIGHT groups",
      general_opts,
    },
    -- replace tabufline binds with native
    ["<tab>"] = {
      "<cmd>bnext<cr>",
      "Goto next buffer",
      general_opts,
    },

    ["<c-tab>"] = {
      "<cmd>bprev<cr>",
      "Goto prev buffer",
      general_opts,
    },
    ------------------------------------------------------------[ Splits group ]
    --hack to get a quick leader driven access to <C-w> binds
    ["<leader>v"] = {
      "<cmd>lua vim.api.nvim_input('<c-w>')<cr>",
      " Splits",
      general_opts,
    },
    ---------------------------------------------------------------[ Go group ]
    ["<leader>gb"] = {
      "<cmd>Telescope buffers <CR>",
      "Go to Telescope BUFFERS",
      general_opts,
    },

    -- binds alternative to tab
    ["<leader>g]"] = {
      "<cmd>bnext<cr>",
      "Goto next buffer",
      general_opts,
    },

    ["<leader>g["] = {
      "<cmd>bprev<cr>",
      "Goto prev buffer",
      general_opts,
    },

    ["<leader>g1"] = {
      "<CMD>lua Go_to_buf(1)<CR>",
      "Go to buf 1",
      general_opts,
    },

    ["<leader>g2"] = {
      "<CMD>lua Go_to_buf(2)<CR>",
      "Go to buf 2",
      general_opts,
    },

    ["<leader>g3"] = {
      "<CMD>lua Go_to_buf(3)<CR>",
      "Go to buf 3",
      general_opts,
    },

    ["<leader>g4"] = {
      "<CMD>lua Go_to_buf(4)<CR>",
      "Go to buf 4",
      general_opts,
    },

    ["<leader>g5"] = {
      "<CMD>lua Go_to_buf(5)<CR>",
      "Go to buf 5",
      general_opts,
    },

    ["<leader>g6"] = {
      "<CMD>lua Go_to_buf(6)<CR>",
      "Go to buf 6",
      general_opts,
    },

    ["<leader>g7"] = {
      "<CMD>lua Go_to_buf(7)<CR>",
      "Go to buf 7",
      general_opts,
    },

    ["<leader>g8"] = {
      "<CMD>lua Go_to_buf(8)<CR>",
      "Go to buf 8",
      general_opts,
    },

    ["<leader>g9"] = {
      "<CMD>lua Go_to_buf(9)<CR>",
      "Go to buf 9",
      general_opts,
    },
    ---------------------------------------------------[ Sourcegraph/Cody group]
    ["<leader>ss"] = {
      "<CMD>SourcegraphSearch<CR>",
      "Sourcegraph SEARCH",
      general_opts,
    },

    ["<leader>sl"] = {
      "<CMD>SourcegraphLink<CR>",
      "Sourcegraph LINK",
      general_opts,
    },

    ["<leader>sc"] = {
      "<CMD>CodyToggle<CR>",
      "Toggle Cody CHAT",
      general_opts,
    },

    ["<leader>sa"] = {
      "<CMD>lua CodyAskFlow()<CR>",
      "ASK Cody about selection",
      general_opts,
    },

    ["<leader>st"] = {
      "<CMD>lua CodyTaskFlow()<CR>",
      "Give Cody a TASK",
      general_opts,
    },
  },
  v = {
    ----------------------[ fix polluting clipboard with non cutting operations]
    ["c"] = {
      '"_c',
      "",
      general_opts,
    },

    ["x"] = {
      '"_x',
      "",
      general_opts,
    },

    ["d"] = {
      '"_d',
      "",
      general_opts,
    },
    -----------------------------------------------[ Search and replace group ]
    ["<leader>rs"] = {
      "<CMD>SearchReplaceWithinVisualSelection<CR>",
      "Replace inside SELECTION",
      general_opts,
    },

    ["<leader>rw"] = {
      "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>",
      "Replace word under cursor inside SELECTION",
      general_opts,
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "Code ACTIONS from LSP",
      general_opts,
    },
    --[ Don't replace clipboard when pasting over + position the cursor after ]
    ["p"] = {
      "gP",
      "",
      general_opts,
    },
  },
  -------------------------------------------------------[ Exit term with Esc ]
  t = {
    ["<Esc>"] = {
      "<cmd>ToggleTerm<cr>",
      "Toggle TERM",
      general_opts,
    },
  },
}

--------------------------------[ Disabled native and distro provided mappings ]
M.disabled = {
  n = {
    ["<leader>d"] = "",
    ["<leader>D"] = "",
    ["<leader>rs"] = "",
    ["<C-s>"] = "",
    ["<leader>b"] = "",
    ["<leader>w"] = "",
    ["<leader>wa"] = "",
    ["<leader>wk"] = "",
    ["<leader>wK"] = "",
    ["<leader>wl"] = "",
    ["<leader>wr"] = "",
    ["<leader>q"] = "",
    ["<leader>h"] = "",
    ["<leader>n"] = "",
    ["<leader>r"] = "",
    ["<leader>ra"] = "",
    ["<leader>rn"] = "",
    ["<leader>rh"] = "",
    ["<leader>v"] = "",
    ["<leader>ff"] = "",
    ["<leader>fa"] = "",
    ["<leader>fw"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fo"] = "",
    ["<leader>fz"] = "",
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",
    ["<leader>gb"] = "",
    ["<leader>pt"] = "",
    ["<leader>ph"] = "",
    ["<leader>th"] = "",
    ["<leader>ch"] = "",
    ["<leader>ma"] = "",
    ["<leader>t"] = "",
    ["<leader>ls"] = "",
    ["<leader>lf"] = "",
    ["<leader>x"] = "",
    ["<C-c>"] = "",
    ["<Up>"] = "",
    ["<Down>"] = "",
    ["<Left>"] = "",
    ["<Right>"] = "",
    ["<cr>"] = "",
    ["<S-tab>"] = "",
    ["<leader>fm"] = "",
    ["s"] = "",
  },
}
return M

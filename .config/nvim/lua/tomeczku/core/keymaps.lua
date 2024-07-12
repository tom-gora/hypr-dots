local map = vim.keymap.set
local ignore = { desc = "which_key_ignore" }
-- ADDITIONAL ISOLATED FIXES
-- don't need to be put in a tables to map by iteration
--
--fix polluting clipboard on pasting over visual selection
map("x", "p", "P", ignore)
-- dedicated remap for command mode to use without arrow keys
-- and c-j c-k addition for navigating compe completions
-- src for the latter: https://www.reddit.com/r/neovim/comments/ofg7tu/use_cj_and_ck_in_nvimcompe_instead_of_cp_cn/
map("c", "<c-l>", "<right>", { noremap = false })
map("c", "<c-h>", "<left>", { noremap = false })
-- HACK: This worked! Dunno why tho??
vim.cmd [[
cmap <C-j> <C-n>
cmap <C-k> <C-p>
]]

-- maps in tables to iterate over

-- normal mode maps table
local n_nonrecursive = {}
-- visual mode maps table
local v_nonrecursive = {}
-- insert mode maps table
local i_nonrecursive = {}
-- normal && visual maps table
local nv_nonrecursive = {}

-- declare normal mode keymaps key:bindig -> value:command, value: opts table
n_nonrecursive = {
  --  fix polluting clipboard with non cutting operations
  ["ciw"] = { '"_ciw', ignore, },
  ["caw"] = { '"_caw', ignore, },
  -- select all buf lines quickly
  ["<leader>a"] = { "ggVG", ignore, },
  --
  -- position the cursor after pasted in text
  ["p"] = { "gp", ignore },
  -- explicityly call native lsp action on go to file seems to fix
  -- misbehavior relating to relative paths....
  ["gf"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", ignore },
  -- toggle oil pane
  ["<leader>e"] = { "<Cmd>Oil --float<CR>", { desc = "󰏇 Toggle Oil" } },
  -- toggle comment line in normal mode
  ["<leader>/"] = { "gcc", vim.tbl_deep_extend("force", ignore, { remap = true }) },
  -- clear search highlights
  ["<Esc>"] = { "<cmd> noh <CR>", ignore },
  -- ["jk"] = { "<cmd> noh <CR>", ignore },
  -- write buffer
  ["<leader>w"] = { "<cmd>w<cr>", ignore },
  -- write all bufs
  ["<leader>W"] = { "<cmd>wa<cr>", ignore },
  -- leader driven alias for c-w
  ["<leader>v"] = { "<cmd>lua vim.api.nvim_input('<c-w>')<cr>", { desc = " Splits" } },
  -- jump between bufs back and forth
  -- barbar with native nvim fallback
  ["<S-l>"] = {
    function()
      return pcall(require, "barbar") and "<cmd>BufferNext<cr>" or "<cmd>bnext<cr>"
    end,
    vim.tbl_deep_extend("force", ignore, { expr = true }),
  },
  ["<S-h>"] = {
    function()
      return pcall(require, "barbar") and "<cmd>BufferPrevious<cr>" or "<cmd>bnext<cr>"
    end,
    vim.tbl_deep_extend("force", ignore, { expr = true }),
  },
  -- whichkey neovim section
  ["<leader>n"] = { " NeoVim" },
  ["<leader>ns"] = { "<cmd>lua _G.ClearSwap()<CR>", { desc = "Clear the Swap" } },
  -- ["<leader>nl"] = { "<cmd>Lazy<CR>", { desc = "Open Lazy" } },
  ["<leader>nm"] = { "<cmd>Mason<CR>", { desc = "Open Mason" } },
  ["<leader>nc"] = { "<cmd>checkhealth<CR>", { desc = "Do Checkhealth" } },
  ["<leader>nh"] = { "<cmd> Telescope highlights <CR>", { desc = "Look up HL Groups" } },
  ["<leader>n?"] = { "<cmd> Telescope help_tags <CR>", { desc = "Help 󰋗 " } },
  --
  -- whichkey goto section
  ["<leader>g"] = { " Go To" },
  ["<leader>gb"] = { "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" } },
  ["<leader>gp"] = { "<cmd>BufferPick<cr>", { desc = "Pick Buffer from Tabline" } },
  -- Goto buffer in position...
  ["<leader>g1"] = { "<Cmd>BufferGoto 1<CR>", { desc = "Go to Buffer Index 1" } },
  ["<leader>g2"] = { "<Cmd>BufferGoto 2<CR>", { desc = "Go to Buffer Index 2" } },
  ["<leader>g3"] = { "<Cmd>BufferGoto 3<CR>", { desc = "Go to Buffer Index 3" } },
  ["<leader>g4"] = { "<Cmd>BufferGoto 4<CR>", { desc = "Go to Buffer Index 4" } },
  ["<leader>g5"] = { "<Cmd>BufferGoto 5<CR>", { desc = "Go to Buffer Index 5" } },
  ["<leader>g6"] = { "<Cmd>BufferGoto 6<CR>", { desc = "Go to Buffer Index 6" } },
  ["<leader>g7"] = { "<Cmd>BufferGoto 7<CR>", { desc = "Go to Buffer Index 7" } },
  ["<leader>g8"] = { "<Cmd>BufferGoto 8<CR>", { desc = "Go to Buffer Index 8" } },
  ["<leader>g9"] = { "<Cmd>BufferGoto 9<CR>", { desc = "Go to Buffer Index 9" } },
  ["<leader>g0"] = { "<Cmd>BufferLast<CR>", { desc = "Go to Last Buffer" } },
  --
  -- lazygit
  ["<leader>G"] = { "<cmd>LazyGit<cr>", { desc = "󰊢 LazyGit" } },

  --
  -- whichkey find and telescope section
  ["<leader>f"] = { " Find" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<CR>", { desc = "Find Files" } },
  ["<leader>fw"] = { "<cmd>Telescope grep_string<cr>", { desc = "Find Word Under Cursor/Selection" } },
  -- Goto buffer in position...
  ["<leader>fo"] = { "<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", { desc = "Find in Opened Files" } },
  ["<leader>fb"] = { "<Cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in Current Buffer" } },
  ["<leader>fd"] = { "<Cmd>Telescope live_grep<CR>", { desc = "Find in CWD" } },
  ["<leader>fa"] = { "<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "Find All Files (hidden etc.)" } },
  ["<leader>fp"] = { "<Cmd>Telescope pickers<CR>", { desc = "Recent Pickers" } },
  ["<leader>fh"] = { "<Cmd>Telescope search_history<CR>", { desc = "Search History" } },
  ["<leader>fu"] = { "<Cmd>Telescope undo<CR>", { desc = "Find in Undo Tree" } },
  ["<leader>fs"] = { "<Cmd>Telescope symbols<CR>", { desc = "Find Symbols" } },
  ["<leader>fe"] = { "<Cmd>Telescope file_browser<CR>", { desc = "Find in File Explorer" } },
  ["<leader>fc"] = { "<Cmd>TodoTelescope<CR>", { desc = "Find Todo Comments" } },
  --
  -- whichkey terminal section
  ["<leader>t"] = { " Terminal" },
  ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating TERM" } },
  ["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal TERM" } },
  ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical TERM" } },
  --
  -- navigate splits
  ["<C-h>"] = { "<C-w>h", ignore },
  ["<C-l>"] = { "<C-w>l", ignore },
  ["<C-j>"] = { "<C-w>j", ignore },
  ["<C-k>"] = { "<C-w>k", ignore },

  -- whichkey replace section
  ["<leader>r"] = { "李Replace" },
  ["<leader>rw"] = { "Replace Cword" },
  ["<leader>rr"] = { "Replace Init" },
  ["<leader>rwi"] = { "<cmd>lua SearchReplaceCword(true)<cr>", { desc = "Replace Cword Ignore Case" } },
  ["<leader>rwp"] = { "<cmd>lua SearchReplaceCword(false)<cr>", { desc = "Replace Cword Preserve Case" } },
  ["<leader>rri"] = { "<cmd>lua SearchReplaceInit(true)<cr>", { desc = "Replace Ignore Case" } },
  ["<leader>rrp"] = { "<cmd>lua SearchReplaceInit(false)<cr>", { desc = "Replace Preserve Case" } },
  --
  -- name the mappings for text-case plugin to keep the consistent whichkey look
  ["<leader>~"] = { "󰬴 TextCase" },
  -- lspsaga section
  ["<leader>l"] = { "  LSP" },
  ["<leader>li"] = { "<cmd>LspInfo<cr>", { desc = "Lsp Info" } },
  ["<leader>lD"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Show Line Diagnostics" } },
  ["<leader>ld"] = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", { desc = "Show Diagnostics" } },
  ["<leader>lb"] = { "<cmd>Lspsaga show_buf_diagnostics<cr>", { desc = "Show Diagnostics" } },
  ["<leader>ll"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic" } },
  ["<leader>lh"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Previous Diagnostic" } },
  ["<leader>lk"] = { "<cmd>Lspsaga hover_doc<cr>", { desc = "Show Hover" } },
  ["<leader>lw"] = { "<cmd>Lspsaga winbar_toggle<cr>", { desc = "Toggle Breadcrumbs" } },
  ["<leader>lp"] = { "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek Definition" } },
  ["<leader>lP"] = { "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Peek Type Definition" } },
  ["<leader>lg"] = { "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto Definition" } },
  ["<leader>lG"] = { "<cmd>Lspsaga goto_type_definition<cr>", { desc = "Goto Type Definition" } },
  ["<leader>lr"] = { "<cmd>Lspsaga rename<cr>", { desc = "Lsp Rename" } },
  ["<leader>lo"] = { "<cmd>Lspsaga outline<cr>", { desc = "Show Outline" } },
  ["<leader>lf"] = { "<cmd>Lspsaga finder<cr>", { desc = "Show Symbol Finder" } },
  ["<leader>lL"] = { "<cmd>Lspsaga open_log<cr>", { desc = "Open LspSaga Log" } },
  ["<leader>lc"] = { "<cmd>Lspsaga code_action<cr>", { desc = "Lsp Code Action" } },
}

-- declare insert mode keymaps key:bindig -> value:command, value: opts table
i_nonrecursive = {
  --
  --
  -- navigate within insert mode
  ["<C-h>"] = { "<Left>", ignore },
  ["<C-l>"] = { "<Right>", ignore },
  ["<C-j>"] = { "<Down>", ignore },
  ["<C-k>"] = { "<Up>", ignore },
}

-- declare visual mode keymaps key:bindig -> value:command, value: opts table
v_nonrecursive = {
  --
  -- toggle comment line in visual mode
  ["<leader>/"] = {
    "gc",
    vim.tbl_deep_extend("force", ignore, { remap = true }),
  },
  -- search and replace section
  ["<leader>r"] = { "李Replace" },
  ["<leader>rs"] = { ":lua SearchReplaceVisualSelection()<cr>", { desc = "Replace the Selection" } },
  ["<leader>rii"] = { ":lua SearchReplaceInsideVisualSelection(true)<cr>", { desc = "Inside Selection Ignore Case" } },
  ["<leader>rip"] = { ":lua SearchReplaceInsideVisualSelection(false)<cr>", { desc = "Inside Selection Preserve Case" } },
}

-- declare normal and visual mode keymaps key:bindig -> value:command, value: opts table
nv_nonrecursive = {
  ["c"] = { '"_c', ignore, },
  ["x"] = { '"_x', ignore, },
  ["d"] = { '"_d', ignore, },
  --
  -- quick visual line select
  ["<leader><leader>"] = { "V", ignore },
  --
  -- whichkey open section
  ["<leader>o"] = { " Open" },
  ["<leader>on"] = { "<cmd> enew <CR>", { desc = "Open New Buffer" } },
  ["<leader>of"] = {
    function()
      local root_path = vim.fn.expand("%:p:h")
      return ":e " .. root_path .. "/"
    end,
    { desc = "Open...", expr = true },
  },
  ["<leader>oc"] = { "<cmd> e#<CR>", { desc = "Reopen Last Closed" } },
  ["<leader>or"] = { "<cmd>Telescope oldfiles<CR>", { desc = "Open Recent" } },
  ["<leader>ot"] = { "<Cmd>Telescope file_browser<CR>", { desc = "Open With Telescope" } },
  ["<leader>oq"] = { "<Cmd>copen<CR>", { desc = "Open Quickfix List" } },
  --
  -- whichkey close section
  ["<leader>q"] = { " Close" },
  ["<leader>qq"] = {
    function()
      return pcall(require, "barbar") and "<cmd>BufferClose<cr>" or "<cmd>bd<cr>"
    end,
    { expr = true, desc = "Close Current Buffer" },
  },
  ["<leader>qw"] = { "<cmd>qa!<cr>", { desc = "Force Close Neovim" } },
  ["<leader>qa"] = { "<cmd>%bd!<cr>", { desc = "Close All Buffers" } },
  ["<leader>qo"] = { "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Close All Other Buffers" } },
  ["<leader>qu"] = { "<cmd>lua _G.CloseUnmodifiedBuffers()<CR>", { desc = "Close All Unmodified Buffers" } },
}

-- loop over n_nonrecursive bindings and set the keymaps
for k, v in pairs(n_nonrecursive) do
  map("n", k, v[1], v[2])
end

-- loop over i_nonrecursive bindings and set the keymaps
for k, v in pairs(i_nonrecursive) do
  map("i", k, v[1], v[2])
end

-- loop over v_nonrecursive bindings and set the keymaps
for k, v in pairs(v_nonrecursive) do
  map("v", k, v[1], v[2])
end

-- loop over nv_nonrecursive bindings and set the keymaps
for k, v in pairs(nv_nonrecursive) do
  map({ "n", "v" }, k, v[1], v[2])
end

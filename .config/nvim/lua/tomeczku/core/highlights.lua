-- for overriding the highlight groups
local function mod_hl(hl_name, opts)
	local is_ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })
	if is_ok then
		for k, v in pairs(opts) do
			hl_def[k] = v
			vim.api.nvim_set_hl(0, hl_name, hl_def)
		end
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	group = vim.api.nvim_create_augroup("Color", {}),
	pattern = "*",
	callback = function()
    -- hls for tabline
		mod_hl("BufferCurrentSignRight", { bg = "#191724", fg = "#102a34" })
		mod_hl("BufferCurrentSign", { bg = "#191724", fg = "#102a34" })
		mod_hl("BufferCurrent", { bg = "#102a34", bold = true })
		mod_hl("BufferCurrentIndex", { bg = "#102a34", bold = true })
		mod_hl("BufferCurrentMod", { fg = "#b4637a", bg = "#102a34" })
		mod_hl("BufferDefaultTabpageFill", { bg = "#191724" })
		mod_hl("BufferVisible", { fg = "#232136", bg = "#575279", bold = true })
		mod_hl("BufferVisibleMod", { fg = "#4b242f", bg = "#575279" })
		mod_hl("BufferVisibleSign", { bg = "#191724", fg = "#575279" })
		mod_hl("BufferVisibleIndex", { fg = "#232136", bg = "#575279", bold = true })
    -- modifications to various float windows: telescope, oil etc
		mod_hl("FloatBorder", { fg = "#56949f", bg = "#191724"})
		mod_hl("Float", { bg = "#191724"})
		mod_hl("NormalFloat", { bg = "#191724"})
		mod_hl("WhichKeyFloat", { bg = "#191724"})
    mod_hl("TelescopeBorder", { link = "FloatBorder", force = true })
    mod_hl("TelescopeTitle", { fg = "#c4a7e7", link = "TelescopeTitle", force = true })
		mod_hl("LazyBackdrop", { bg = "#191724", force = true})
    -- costom rainbow-delimiters colors (base rose-pine with bumped up saturation)
    mod_hl("RainbowDelimiterYellow",{ fg="#fdc270", force = true })
    mod_hl("RainbowDelimiterRed",   { fg="#fa608b", force = true })
    mod_hl("RainbowDelimiterOrange",{ fg="#fa8b87", force = true })
    mod_hl("RainbowDelimiterBlue",  { fg="#239acb", force = true })
    mod_hl("RainbowDelimiterGreen", { fg="#8bdae9", force = true })
    mod_hl("RainbowDelimiterViolet",{ fg="#c49cf2", force = true })
    mod_hl("RainbowDelimiterCyan",  { fg="#3c2e9d", force = true })
    -- highlights for statusline that I wrote for old nvchad config that I lifted and modified to my needs
    -- my custom hls used in this statusline config:
    mod_hl("St_NormalMode_Root_Sep", { bg = "#191724", fg = "#d7827e", bold = false })
    mod_hl("St_VisualMode_Root_Sep", { bg = "#191724", fg = "#a3d6df", bold = false })
    mod_hl("St_InsertMode_Root_Sep", { bg = "#121019", fg = "#bb9ede", bold = false })
    mod_hl("St_TerminalMode_Root_Sep", { bg = "#121019", fg = "#abe9b3", bold = false })
    mod_hl("St_NTerminalMode_Root_Sep",{ bg = "#121019", fg = "#d7827e", bold = false })
    mod_hl("St_ReplaceMode_Root_Sep", { bg = "#121019", fg = "#f6c177", bold = false })
    mod_hl("St_SelectMode_Root_Sep", { bg = "#121019", fg = "#8bbec7", bold = false })
    mod_hl("St_CommandMode_Root_Sep", { bg = "#121019", fg = "#abe9b3", bold = false })
    mod_hl("St_ConfirmMode_Root_Sep", { bg = "#121019", fg = "#6aadc8", bold = false })
    mod_hl("St_Root", { bg = "#121019", fg = "#bcbac9", bold = false })
    mod_hl("St_Root_Sep_Right",{ bg = "#262431", fg = "#121019", bold = false })
    mod_hl("St_NormalModeCustomTxt", { bg = "#d7827e", fg = "#191724", bold = true })
    mod_hl("St_VisualModeCustomTxt", { bg = "#a3d6df", fg = "#191724", bold = true })
    mod_hl("St_InsertModeCustomTxt", { bg = "#bb9ede", fg = "#191724", bold = true })
    mod_hl("St_TerminalModeCustomTxt", { bg = "#abe9b3", fg = "#191724", bold = true })
    mod_hl("St_NTerminalModeCustomTxt", { bg = "#abe9b3", fg = "#191724", bold = true })
    mod_hl("St_ReplaceModeCustomTxt", { bg = "#f6c177", fg = "#191724", bold = true })
    mod_hl("St_SelectModeCustomTxt", { bg = "#8bbec7", fg = "#191724", bold = true })
    mod_hl("St_CommandModeCustomTxt", { bg = "#abe9b3", fg = "#191724", bold = true })
    mod_hl("St_ConfirmModeCustomTxt", { bg = "#6aadc8", fg = "#191724", bold = true })
    -- default hls used by nvchad extracted from that old config and injected into my config
    mod_hl("St_CommandMode", { bg = 1644324, bold = true, fg = 11266483})
    mod_hl("St_CommandModeCustomTxt", { bg = 11266483, bold = true, fg = 1644324})
    mod_hl("St_CommandModeSep", { bg = 1644324, bold = true, fg = 11266483})
    mod_hl("St_CommandMode_Root_Sep", { bg = 1183769, fg = 11266483})
    mod_hl("St_CommandmodeText", { bg = 2499633, bold = true, fg = 11266483})
    mod_hl("St_ConfirmMode", { bg = 1644324, bold = true, fg = 6991304})
    mod_hl("St_ConfirmModeCustomTxt", { bg = 6991304, bold = true, fg = 1644324})
    mod_hl("St_ConfirmModeSep", { bg = 1644324, bold = true, fg = 6991304})
    mod_hl("St_ConfirmMode_Root_Sep", { bg = 1183769, fg = 6991304})
    mod_hl("St_ConfirmmodeText", { bg = 2499633, bold = true, fg = 6991304})
    mod_hl("St_EmptySpace", { fg = 1644324})
    mod_hl("St_EmptySpace2", { fg = 1644324})
    mod_hl("St_InsertMode", { bg = 1644324, bold = true, fg = 12295902})
    mod_hl("St_InsertModeCustomTxt", { bg = 12295902, bold = true, fg = 1644324})
    mod_hl("St_InsertModeSep", { bg = 1644324, bold = true, fg = 12295902})
    mod_hl("St_InsertMode_Root_Sep", { bg = 1183769, fg = 12295902})
    mod_hl("St_InsertmodeText", { bg = 2499633, bold = true, fg = 12295902})
    mod_hl("St_LspHints", { fg = 12888039})
    mod_hl("St_LspInfo", { fg = 11266483})
    mod_hl("St_LspProgress", { fg = 11266483})
    mod_hl("St_LspStatus_Icon", { bg = 8829378, fg = 1644324})
    mod_hl("St_NTerminalMode", { bg = 1644324, bold = true, fg = 14123646})
    mod_hl("St_NTerminalModeCustomTxt", { bg = 11266483, bold = true, fg = 1644324})
    mod_hl("St_NTerminalModeSep", { bg = 1644324, bold = true, fg = 16171383})
    mod_hl("St_NTerminalMode_Root_Sep", { bg = 1183769, fg = 14123646})
    mod_hl("St_NTerminalmodeText", { bg = 2499633, bold = true, fg = 16171383})
    mod_hl("St_NormalMode", { bg = 1644324, bold = true, fg = 14123646})
    mod_hl("St_NormalModeCustomTxt", { bg = 14123646, bold = true, fg = 1644324})
    mod_hl("St_NormalModeSep", { bg = 1644324, bold = true, fg = 9158343})
    mod_hl("St_NormalMode_Root_Sep", { bg = 1183769, fg = 14123646})
    mod_hl("St_NormalmodeText", { bg = 2499633, fg = 14123646})
    mod_hl("St_Pos_bg", { bg = 16171383, fg = 1644324})
    mod_hl("St_Pos_sep", { bg = 1644324, fg = 16171383})
    mod_hl("St_Pos_txt", { bg = 2499633, fg = 16171383})
    mod_hl("St_ReplaceMode", { bg = 1644324, bold = true, fg = 16171383})
    mod_hl("St_ReplaceModeCustomTxt", { bg = 16171383, bold = true, fg = 1644324})
    mod_hl("St_ReplaceModeSep", { bg = 1644324, bold = true, fg = 16171383})
    mod_hl("St_ReplaceMode_Root_Sep", { bg = 1183769, fg = 16171383})
    mod_hl("St_ReplacemodeText", { bg = 2499633, bold = true, fg = 16171383})
    mod_hl("St_Root", { bg = 1183769, fg = 12368585})
    mod_hl("St_Root_Sep_Right", { bg = 2499633, fg = 1183769})
    mod_hl("St_SelectMode", { bg = 1644324, bold = true, fg = 9158343})
    mod_hl("St_SelectModeCustomTxt", { bg = 9158343, bold = true, fg = 1644324})
    mod_hl("St_SelectModeSep", { bg = 1644324, bold = true, fg = 9158343})
    mod_hl("St_SelectMode_Root_Sep", { bg = 1183769, fg = 9158343})
    mod_hl("St_SelectmodeText", { bg = 2499633, bold = true, fg = 9158343})
    mod_hl("St_TerminalMode", { bg = 1644324, bold = true, fg = 11266483})
    mod_hl("St_TerminalModeCustomTxt", { bg = 11266483, bold = true, fg = 1644324})
    mod_hl("St_TerminalModeSep", { bg = 1644324, bold = true, fg = 11266483})
    mod_hl("St_TerminalMode_Root_Sep", { bg = 1183769, fg = 11266483})
    mod_hl("St_TerminalmodeText", { bg = 2499633, bold = true, fg = 11266483})
    mod_hl("St_VisualMode", { bg = 1644324, bold = true, fg = 10737375})
    mod_hl("St_VisualModeCustomTxt", { bg = 10737375, bold = true, fg = 1644324})
    mod_hl("St_VisualModeSep", { bg = 1644324, bold = true, fg = 10737375})
    mod_hl("St_VisualMode_Root_Sep", { bg = 1183769, fg = 10737375})
    mod_hl("St_VisualmodeText", { bg = 2499633, bold = true, fg = 10737375})
    mod_hl("St_cwd_bg", { bg = 16171383, fg = 1644324})
    mod_hl("St_cwd_sep", { bg = 1644324, fg = 16171383})
    mod_hl("St_cwd_txt", { bg = 2499633, fg = 16171383})
    mod_hl("St_file_bg", { bg = 15429522, fg = 1644324})
    mod_hl("St_file_info", { fg = 14737140})
    mod_hl("St_file_sep", { bg = 1644324, fg = 15429522})
    mod_hl("St_file_txt", { bg = 2499633, fg = 15429522})
    mod_hl("St_gitIcons", { bold = true, fg = 9012897})
    mod_hl("St_lspError", { fg = 15429522})
    mod_hl("St_lspWarning", { fg = 16171383})
    mod_hl("St_lsp_bg", { bg = 11266483, fg = 1644324})
    mod_hl("St_lsp_sep", { bg = 1644324, fg = 11266483})
    mod_hl("St_lsp_txt", { bg = 2499633, fg = 11266483})
    mod_hl("St_sep_r", { fg = 2499633})

	end,
})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})

-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞


-- call the function constructing the statusline
vim.opt.statusline = "%!v:lua.require('tomeczku.core.custom_statusline.statusline').compose_statusline()"
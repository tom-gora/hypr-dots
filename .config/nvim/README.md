# My Neovim configuration

This is my private custom configuration for Neovim. No distros. Sub-40 plugins and shrinking 💪💪💪

## Plugins

Plugins managed by `lazy.nvim` while native package manager is still only on the roadmap:

- barbar.nvim
- better-escape.nvim
- blink-cmp-supermaven
- blink.cmp
- boole.nvim
- cmdline-hl.nvim
- conform.nvim
- css-vars.nvim
- cutlass.nvim
- friendly-snippets
- gitsigns.nvim
- hlargs.nvim
- lazy.nvim
- lazydev.nvim
- LuaSnip
- markdown-preview.nvim
- mason.nvim
- mini.ai
- mini.move
- mini.surround
- nvim-aider
- nvim-highlight-colors
- nvim-treesitter
- nvim-ts-autotag
- nvim-web-devicons
- oil.nvim
- plenary.nvim
- rainbow-delimiters.nvim
- snacks.nvim
- supermaven-nvim
- tailwind-tools.nvim
- todo-comments.nvim
- ultimate-autopair.nvim
- vim-tmux-navigator
- which-key.nvim
- nvim-silicon
- quicker.nvim
- text-case.nvim
- trouble.nvim

## Custom Features and Modules

- **Custom Statusline Components:**
  ![statusline](./repo_assets/status_all.png)
  - Custom styled components for important indicators, including dynamic path formatting (shortened or full based on window width) and LSP status display with icons and client names.
  - Markdown word count display with debouncing and stripping of non-text elements like HTML tags and code blocks.
- **Specific Keymap Configurations:**
  - Keymaps organized into modules for normal, visual, insert, normal+visual, and terminal modes.
  - Filetype-specific keymaps for Lua, Markdown, Laravel, help files, Trouble, and the quickfix list.
- **Native LSP Configurations:**
  - Direct LSP configurations for various language servers (Lua, Bash, Emmet, Astro, PHPactor, TailwindCSS, TypeScript, HTML, Gopls, YAML, CSS, Harper, Docker Compose) without relying on nvim-lspconfig abstractions or intermediary setup plugins. No wrappers, just plain `vim.lsp.config()` calls. Only `mason` is used as frontend to manage package installs and retrieve their metadata.
  - Native (no plugins) diagnostics setup with specific icons, virtual text formatting (including showing the count of diagnostics on a line).
  - Autocommands adjusting certain lsp behaviors.
- **Custom Theme Implementation:**
  - Theme adapted locally from base-46 implementation of `rose-pine`.
  - Programmatic calculation and modification of colors for various highlight groups based on a base palette (things like darkening, lightening, muting, and saturating retrieved colors).
- **Modular Configuration Structure:**
  - Configuration broken down into core modules (autocommands, statusline, theme, keymaps, lsp, vim_opts) and plugin configurations.
- **AI Integrations:**
  - Supermaven for free AI completions always disabled by default, with quick keymap to toggle on/off in case help is needed. Completes via blink and uses no traditional AI ghost text to minimize flickering and code "jumping around the buffer" 😉
  - Aider as terminal vibing assistant, with quick toggle keymap to switch between models more appropriate for coding and for text writing 🤓

## Installation

To install this Neovim configuration:

1.  Clone the repository:
2.  Take what you want. You are on your own 😉

## Screenshots

Screenshots showcasing the configuration's appearance and features will be added here.

- Custom Keybindings: [[screenshot_needed]]
- Statusline Modules:
  - Integrated Mode/Root/Path
  - Git
  - AI Status
  - Wordcounter for Markdown
  - Attached LSPs
  - Diagnostics Type and Count
  - Cursor Position
- LSP Integration: [[screenshot_needed]]
- Custom Themes: [[screenshot_needed]]
- Markdown Word Count: [[screenshot_needed]]

## License

This configuration is private and not intended for distribution. You are free to take anything you want, but there are no guarantees or support provided. This work is released into the public domain under the Unlicense. See the UNLICENSE file for details.

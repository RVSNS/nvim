# Neovim config — Bill of Materials

This repo is fully self-bootstrapping: `git clone` it to `~/.config/nvim` on any
machine, open `nvim`, and `lazy.nvim` + `mason-tool-installer` install everything
below automatically (exact versions pinned in `lazy-lock.json`).

## Plugins

| Plugin | Spec file | Purpose | Why it's here |
|---|---|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | `init.lua` | Plugin manager | Installs/updates/lazy-loads everything else; pins exact commits via `lazy-lock.json` for reproducible setup across machines |
| [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) | `gruvbox.lua` | Color scheme | Visual theme |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | `nvim-tree.lua` | File explorer sidebar | VSCode-style file tree (`<leader>e`) |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | dependency of nvim-tree/bufferline/fzf-lua | Filetype icons | Shared icon set other UI plugins render next to filenames |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | `bufferline.lua` | Tab bar for open buffers | VSCode-style row of open-file tabs (`Shift-H`/`Shift-L` to cycle, `<leader>bd` to close) |
| [mini.statusline](https://github.com/echasnovski/mini.nvim) | `mini.lua` | Statusline | Lightweight status bar (mode, filename, diagnostics, git branch); part of `mini.nvim`, no extra dependency |
| [mini.pairs](https://github.com/echasnovski/mini.nvim) | `mini.lua` | Autopairing | Auto-closes brackets/quotes; same `mini.nvim` family as mini.statusline, kept minimal on purpose instead of `nvim-autopairs` |
| [indent-blankline.nvim (ibl)](https://github.com/lukas-reineke/indent-blankline.nvim) | `indent-blankline.lua` | Indent guide lines | Vertical `│` guides at every indent level + current-scope highlight |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | `which-key.lua` | Keybinding hint popup | Shows available next-keys when you pause mid-chord (e.g. after `<leader>`) |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | `markdown-preview.lua` | Browser-based markdown preview | Live-reloading full HTML/CSS render in a browser tab (`<leader>mp` to toggle). Downloads a prebuilt preview-server binary on install via `mkdp#util#install()` |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | `mason.lua` | LSP/tool installer manager | Installs and manages the external binaries listed below, puts them on Neovim's `PATH` |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | `mason.lua` | Declarative Mason bootstrap | Ensures the tool list installs automatically on first launch (`run_on_start = true`) — the actual "clone and go" mechanism |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | `treesitter.lua` | Syntax highlighting & indent | Treesitter-based highlighting/indentation; pinned to `master` branch (not the newer `main` rewrite, which dropped the `.configs` API this config uses) |
| [blink.cmp](https://github.com/saghen/blink.cmp) | `blink.lua` | Autocomplete engine | The actual "IntelliSense popup" — pulls completions from LSP, buffer words, paths, snippets. Chosen over `nvim-cmp` for speed/fewer deps |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | `conform.lua` | Format-on-save | Runs `gofumpt`/`goimports`/`stylua`/`shfmt` automatically on save (also `<leader>cf` to format on demand) |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | `fzf-lua.lua` | Fuzzy finder | File/grep/buffer/diagnostics search (`<leader>ff/fg/fb/fh/fd`, `<leader><leader>` for files). Chosen over `telescope.nvim` to avoid the `plenary.nvim` dependency and for faster matching |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `gitsigns.lua` | Git gutter signs | Inline add/change/delete markers, hunk stage/reset/preview, blame |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | `fugitive.lua` | Git porcelain UI | Full `:Git status`/commit/push/diff/merge-conflict workflow inside Neovim (`<leader>gs`), for anything beyond gitsigns' gutter-level view |
| [snipe.nvim](https://github.com/leath-dub/snipe.nvim) | `snipe.lua` | Buffer switcher | Labels each open buffer with a single key for instant jump (`gb`) |

## Native Neovim features in use (no plugin)

These are built into Neovim 0.11+/0.10+ and deliberately **not** reimplemented with a plugin:

- **LSP client** (`lua/core/lsp.lua`) — `vim.lsp.config()`/`vim.lsp.enable()` wire up `gopls` and `lua_ls` directly. No `nvim-lspconfig` needed since Neovim 0.11.
- **Comment toggling** (`gc`, `gcc`, `gco`, `gcA`) — core since Neovim 0.10, no `Comment.nvim`/`vim-commentary` needed.

## LSP servers / formatters / linters (installed via Mason, not git-managed plugins)

Declared in `lua/plugins/mason.lua`'s `ensure_installed`, auto-installed to
`~/.local/share/nvim/mason/bin` on first launch:

| Tool | Purpose |
|---|---|
| `gopls` | Go language server — autocomplete, diagnostics, go-to-def, hover |
| `gofumpt` | Stricter Go formatter (used by conform.nvim) |
| `goimports` | Auto-manages Go import lines (used by conform.nvim) |
| `golangci-lint` | Go linter aggregator |
| `delve` | Go debugger (DAP) |
| `lua-language-server` | Lua language server — for editing this config itself |
| `stylua` | Lua formatter (used by conform.nvim) |
| `shfmt` | Shell script formatter (used by conform.nvim) |
| `tree-sitter-cli` | Needed by nvim-treesitter to compile parser grammars |

## Local overrides / patches

- `queries/python/highlights.scm` — overrides nvim-treesitter's bundled Python
  highlight query, dropping an `except*` rule that errors against the
  currently-compiled grammar (upstream version-mismatch bug, not something
  config-side could otherwise fix).
- `ftplugin/gowork.lua`, `ftplugin/gotmpl.lua` — empty stub files that register
  `gowork`/`gotmpl` as "known" filetypes to Neovim's completion list, silencing
  a `:checkhealth vim.lsp` false-positive (the filetypes are detected and work
  fine either way; this just satisfies the health check's naming heuristic).

## System-level prerequisites (not git-managed)

These can't be installed via `git clone` — they're OS packages or host config:

- A C compiler (`cc`/`gcc`) — needed by nvim-treesitter to compile parsers.
- `git`, `curl`/`wget`, `tar`, `unzip` — needed by lazy.nvim/mason downloads.
- A **Nerd Font** set as your terminal's font — needed for file-type icons
  (`nvim-web-devicons`) and bufferline's close icon to render correctly instead
  of showing `?`/tofu characters.
- `ripgrep` (optional) — `fzf-lua`'s live grep falls back to plain `grep`
  without it, but `ripgrep` is faster and respects `.gitignore`.

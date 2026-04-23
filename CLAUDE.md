# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## What this repository is

A personal Neovim configuration forked from [kickstart.nvim][kickstart].
Target user: a developer who primarily writes Python (FastAPI/Django-style
backends), TypeScript/React (with Bun), JavaScript/React (with npm), and
edits typical config files (JSON/YAML/TOML).

The codebase is intentionally single-file first: `init.lua` holds options,
keymaps, autocmds, and every plugin spec inline. `lua/custom/plugins/` is the
overflow for plugins that are too large or independent to live inline.

[kickstart]: https://github.com/nvim-lua/kickstart.nvim

## Key commands (inside Neovim)

| Command                 | Purpose                                           |
| ----------------------- | ------------------------------------------------- |
| `:Mason`                | Open the LSP/tool installer TUI (press `g?`)      |
| `:MasonToolsInstall`    | Install everything in `ensure_installed`          |
| `:MasonUninstall <pkg>` | Remove a mason-installed tool                     |
| `:Lazy`                 | Open the plugin manager (install/update/sync)     |
| `:LspInfo`              | Show LSP clients attached to the current buffer   |
| `:LspRestart`           | Restart attached LSPs after editing `servers`     |
| `:checkhealth`          | Diagnose plugin + runtime issues                  |
| `:TSUpdate`             | Update all Treesitter parsers                     |
| `:ConformInfo`          | Show which formatter(s) run on the current buffer |

Scope `:checkhealth` to one plugin: `:checkhealth lazy`, `:checkhealth blink.cmp`.

## Key commands (from the shell)

```bash
# Lint/format init.lua manually (conform runs stylua on save automatically)
stylua init.lua

# Headless smoke test — loads init.lua and exits. Non-zero on Lua errors.
nvim --headless -c 'luafile init.lua' -c 'qa'

# Lint this file and README.md (markdownlint is installed via Mason)
~/.local/share/nvim/mason/bin/markdownlint CLAUDE.md README.md
```

There are no tests in this repo — it's a config, not an application.
Verification is: load Neovim, run `:checkhealth`, open a file of each
target language.

## Architecture

### File layout

```text
init.lua                 # Options → keymaps → autocmds → lazy.setup({...})
lua/custom/plugins/      # Auto-imported by lazy.nvim (init.lua:867)
  ├── init.lua           # Returns {} — placeholder
  └── claude-code.lua    # Example custom plugin spec
lua/kickstart/
  ├── health.lua         # :checkhealth kickstart — verifies external deps
  └── plugins/debug.lua  # DAP setup (optional, imported individually)
doc/kickstart.txt        # Help tags — :help kickstart
.stylua.toml             # 2-space, single quotes, no call parens, 160 col
lazy-lock.json           # Plugin version pins. Committed.
```

### How plugin loading works

1. `init.lua` calls `require('lazy').setup({...}, { ... opts })` once at
   init.lua:143.
1. The spec list includes ~20 inline plugin specs.
1. The final entry `{ import = 'custom.plugins' }` at init.lua:867 makes
   lazy.nvim auto-import every `.lua` file under `lua/custom/plugins/` and
   merge it into the spec list. **This is the extension point** — dropping
   a new `.lua` file there that returns a lazy spec adds a plugin without
   touching `init.lua`.
1. `lua/kickstart/plugins/debug.lua` is loaded explicitly via
   `require 'kickstart.plugins.debug'` at init.lua:866 — it is opt-in,
   not auto-imported.

### Language stack (wired in init.lua:480 `servers` table)

| Language     | LSP                                    |
| ------------ | -------------------------------------- |
| Python       | `basedpyright` (types) + `ruff` (diag) |
| TS/TSX/JS/JSX| `ts_ls` + `eslint` + `tailwindcss`     |
| Lua          | `lua_ls`                               |
| JSON / JSONC | `jsonls`                               |
| YAML         | `yamlls`                               |
| TOML         | `taplo` (also formats)                 |

Formatters (via `conform.nvim`):

- Python → `ruff_fix` + `ruff_format` + `ruff_organize_imports`
- Lua → `stylua`
- JS/TS/JSX/TSX/CSS/HTML/JSON/YAML/Markdown → `prettierd` → `prettier`
- TOML → `taplo`

Linters (via `nvim-lint`): `markdownlint` on Markdown. Python and JS/TS
lint comes from their LSPs (ruff, eslint).

### The mason-lspconfig handler gotcha

The handler at init.lua:539 auto-calls
`require('lspconfig')[server_name].setup(...)` for **every** mason-installed
LSP. Leftover installs (e.g. uninstalling `basedpyright` from the `servers`
table but leaving the Mason package on disk) will keep auto-attaching.
Always `:MasonUninstall <pkg>` when removing a server from the `servers` table.

### Autoformat + auto-lint pipeline

- **conform.nvim** runs on `BufWritePre` (init.lua:555). It looks up
  `formatters_by_ft[ft]` and runs them in order. `stop_after_first = true`
  means only the first available formatter runs (so prettierd wins over
  prettier when the daemon is up).
- **nvim-lint** runs on `BufEnter`, `BufWritePost`, `InsertLeave`
  (init.lua:847). Only markdown currently; Python linting comes from
  the ruff LSP.
- `<leader>f` invokes conform manually with `lsp_format = 'fallback'`
  (init.lua:558).

### Mason auto-install

`ensure_installed` at init.lua:547 is built from `vim.tbl_keys(servers)`
plus extra non-LSP tools (`stylua`, `prettierd`, `prettier`, `markdownlint`).
Adding a server to the `servers` table auto-queues it for install; non-LSP
tools (formatters, linters) must be appended to the `vim.list_extend` call
manually.

### Completion (blink.cmp)

Sources: `lsp`, `path`, `snippets` (LuaSnip + friendly-snippets), `buffer`,
`lazydev` (Lua-aware). The `blink_cmp_fuzzy` binary is a prebuilt Rust
library — downloaded on first install. A `:checkhealth blink.cmp` warning
about "disabled sources" (cmdline/omni) is expected — those are
contextually enabled.

## User-added customizations on top of kickstart

- `<leader>cc` → `:ClaudeCode` (claude-code.nvim terminal toggle)
- `<leader>st` → `:TodoTelescope` (search TODO/FIX/HACK comments)
- `lazy.rocks.enabled = false` (init.lua:864) — disables the luarocks
  health check since no plugins use it
- Defensive guess-indent install:
  `{ 'NMAC427/guess-indent.nvim', opts = {} }`. The bare string form in
  stock kickstart silently failed because lazy.nvim never called
  `setup()` without `opts` or `config`.

## Conventions

- **Comments are mixed French/English.** Stock kickstart uses English;
  user additions are often French. Match the surrounding code — don't
  translate existing comments.
- **Leader key is `<Space>`.** Local leader is also `<Space>`.
- **Split navigation:** `<C-h/j/k/l>` moves focus;
  `<C-S-h/j/k/l>` moves the window itself.
- **Terminal mode escape:** `<Esc><Esc>` (not just `<Esc>`).
- **Nerd font required** (`vim.g.have_nerd_font = true` at init.lua:27).
  If icons render as boxes, the user has a font config issue — do not
  remove the flag.

## When editing init.lua

- Run `stylua init.lua` before committing if conform didn't auto-run.
  The `.stylua.toml` settings are the source of truth (2-space indent,
  single quotes, no call parens for `require 'x'`).
- Headless load check:
  `nvim --headless -c 'luafile init.lua' -c 'qa' 2>&1 | head -30`.
  Silence = pass; Lua errors print to stderr.
- Plugin version pins live in `lazy-lock.json` and are committed.
  Running `:Lazy update` inside Neovim rewrites it — treat that as an
  intentional commit, not a stray diff.

## Commit style

French or English both appear in the log. Conventional prefixes used when
it fits (`feat:`, `fix:`, `refactor:`, `chore:`), otherwise free-form.
Attribution (`Co-Authored-By`) is disabled globally via
`~/.claude/settings.json` — don't add it to commit messages.

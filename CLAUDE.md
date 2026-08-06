# Project: Neovim config (NvChad v2.0 base)

## Overview
- **Type**: Neovim configuration (dotfiles)
- **Stack**: Neovim 0.12.x, lazy.nvim, NvChad v2.0 base, mason.nvim 2.x, mason-lspconfig 2.x, nvim-lspconfig 2.11.x, nvim-cmp
- **Repo root**: `/home/faezix/.dotfiles/configs/.config/nvim` (own git repo, symlinked into `~/.config/nvim`)

## Architecture

Two layers, merged by lazy.nvim:

- `lua/plugins/init.lua` + `lua/plugins/configs/*` — NvChad base specs.
- `lua/custom/plugins/*.lua` — user specs, imported via `M.plugins = "custom.plugins"` in `lua/custom/chadrc.lua`.

**Specs for the same plugin are merged, and `config` is single-valued: the custom
spec's `config` replaces the base one.** Any custom spec that redeclares a plugin
NvChad also declares must call the base config itself, e.g.
`require "plugins.configs.lspconfig"` at the top of the custom `config`.

Mason's `bin/` is put on `$PATH` in `lua/core/init.lua:61`, not by mason.nvim.

## Patterns & Conventions

- LSP servers are configured with `vim.lsp.config(<name>, {...})` (Neovim 0.11+ API).
  Global defaults, including nvim-cmp capabilities, go through `vim.lsp.config("*", {...})`.
  Per-server tables are deep-merged on top of `"*"`.
- Servers are **not** enabled explicitly; mason-lspconfig's `automatic_enable`
  enables every installed server. Use `automatic_enable = { exclude = {...} }` to opt out.
- Formatting is owned by conform.nvim (`lua/custom/plugins/conform.lua`), not by LSP.
  Formatter-only LSP clients (e.g. `stylua --lsp`) must be excluded from `automatic_enable`.

## Learnings & Corrections

- ❌ `mason-lspconfig.setup { handlers = { ... } }` — the `handlers` option was **removed in
  mason-lspconfig v2**. It is silently ignored (not an error), so per-server settings and
  cmp capabilities never reach any server while looking correct.
  ✅ Use `vim.lsp.config(<name>, {...})` + `automatic_enable`.

- ❌ Redeclaring `neovim/nvim-lspconfig` in `lua/custom/plugins/` without calling
  `require "plugins.configs.lspconfig"` silently disables NvChad's LSP setup
  (base46 highlights, `nvchad.lsp`, `lua_ls` config, NvChad `on_attach`).
  ✅ Call the base config first inside the custom `config` function.

- ❌ Symptom "Spawning language server with cmd ... failed" while the binary is listed in
  `~/.local/share/nvim/mason/bin` — the shims are symlinks into
  `mason/packages/<pkg>/node_modules/.bin/`. A global `node_modules` cleanup deletes the
  targets and leaves dangling symlinks, so `$PATH` lookups fail.
  ✅ Detect with a dangling-symlink scan over `mason/bin`, repair by running
  `npm install` in each `mason/packages/<pkg>` that has a `package.json` but no `node_modules`
  (mason's own `package.json`/`package-lock.json` are still there and pin the versions).
  `:MasonInstall <pkg>` also works but is slower.

- `automatic_installation` is a **mason-lspconfig** option, not a mason.nvim option; passing it
  to mason.nvim does nothing.

## Current State

- LSP verified attaching: `lua_ls`, `jsonls`, `ts_ls`, `cssls`, `pyright`, `pylsp`,
  with nvim-cmp capabilities applied.
- **Open**: python gets both `pylsp` and `pyright` (mason `ensure_installed` asks for
  `python-lsp-server`, mason-lspconfig asks for `pyright`) — duplicate diagnostics.
  Pick one and drop the other.
- **Known noise**: `vim.lsp.with() is deprecated` originates in the vendored NvChad `ui`
  plugin (`nvchad/lsp.lua`, `nvchad/signature.lua`), not in this repo.

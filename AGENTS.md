# Neovim Configuration Knowledge Base

**Generated:** 2026-02-26
**Commit:** 75b59bc
**Branch:** main

## Overview

LazyVim-based Neovim configuration using lazy.nvim plugin manager. Lua only, ~440 lines across 10 source files.

## Structure

```
.
├── init.lua                    # Entry point — requires config.lazy, nothing else
├── lua/
│   ├── config/
│   │   ├── lazy.lua            # lazy.nvim bootstrap + plugin spec loading
│   │   ├── options.lua         # Vim options (loaded BEFORE lazy.nvim startup)
│   │   ├── keymaps.lua         # Global keymaps (loaded on VeryLazy) — currently empty
│   │   └── autocmds.lua        # Autocommands (loaded on VeryLazy) — currently empty
│   └── plugins/
│       ├── overrides.lua       # Overrides for LazyVim defaults (LSP, colorscheme)
│       ├── multicursor.lua     # jake-stewart/multicursor.nvim config + keymaps
│       ├── opencode.lua        # opencode.nvim with render-markdown, blink.cmp, snacks deps
│       ├── dap.lua             # DAP configs for NestJS/TypeScript debugging (pwa-node)
│       └── example.lua         # Template file — short-circuited with `if true then return {} end`
├── lazyvim.json                # Enabled LazyVim extras
├── stylua.toml                 # Formatter config
└── .luarc.json                 # LSP config (vim global)
```

## Where to Look

| Task | Location | Notes |
|------|----------|-------|
| Add/modify vim options | `lua/config/options.lua` | Loaded before plugins |
| Add global keymaps | `lua/config/keymaps.lua` | Loaded on VeryLazy event |
| Add autocommands | `lua/config/autocmds.lua` | Loaded on VeryLazy event |
| Add new plugin | `lua/plugins/<name>.lua` | Return table of specs |
| Override LazyVim plugin | `lua/plugins/overrides.lua` | Re-declare plugin with new opts |
| Enable LazyVim extra | `lazyvim.json` | `extras` array |
| Change colorscheme | `lua/plugins/overrides.lua` | tokyonight-storm is active |
| DAP/debugger config | `lua/plugins/dap.lua` | NestJS-specific, uses mason js-debug-adapter |

## Init Order

1. `init.lua` → requires `config.lazy`
2. `config/options.lua` — vim options set (before plugins)
3. lazy.nvim bootstraps (clones itself if missing)
4. LazyVim plugins load (`lazyvim.plugins`)
5. Custom plugins load (`lua/plugins/*.lua`) — **not lazy by default** (`lazy = false`)
6. `config/keymaps.lua` + `config/autocmds.lua` — on `VeryLazy` event

## Enabled LazyVim Extras

- `ai.copilot` — GitHub Copilot
- `dap.core` — Debug adapter protocol
- `formatting.biome` — Biome formatter
- `lang.json` — JSON language support
- `lang.markdown` — Markdown support
- `lang.toml` — TOML support
- `lang.typescript` — TypeScript/TSX support

## Conventions

- **Formatting**: StyLua — 2 spaces, 120 column width
- **Line length**: 120 chars (`textwidth = 120`)
- **Plugin keymaps**: Defined per-plugin in `config = function()` blocks, not centralized
- **Keymap style**: `local set = vim.keymap.set` then `set(modes, key, fn, { desc = "..." })`
- **All keymaps must have `desc`** — follows LazyVim convention for which-key integration
- **Plugin overrides**: Re-declare plugin spec with `opts` to merge — use `overrides.lua` for LazyVim defaults
- **Animations disabled**: `vim.g.snacks_animate = false`, `vim.g.snacks_scroll = false`
- **Inlay hints disabled**: via nvim-lspconfig override

## Anti-Patterns

- `example.lua` is a dead template — short-circuited at line 3. Do not add real config there
- Do not set `lazy = true` globally in `lazy.lua` defaults unless you understand the implications — custom plugins currently expect eager loading
- Do not add keymaps/autocmds directly in `init.lua` — use the dedicated config files

## Commands

```bash
# Format Lua files
stylua .

# Check lazy.nvim lockfile
cat lazy-lock.json | jq .
```

## Notes

- DAP config in `dap.lua` is project-specific to "tad-api" (NestJS) — uses `pnpm run start:debug` and port 9229
- `opencode.nvim` plugin (`sudo-tee/opencode.nvim`) pulls in render-markdown, blink.cmp, snacks as dependencies
- Colorscheme: tokyonight with `storm` style
- Plugin update checker runs silently (`notify = false`)
- Some rtp plugins disabled for performance: gzip, tarPlugin, tohtml, tutor, zipPlugin

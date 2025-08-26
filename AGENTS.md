# Repository Guidelines

## Project Structure & Module Organization
- `init.lua`: Entry point configuring runtime and plugins.
- `lua/`: Main source (modules under `lua/<namespace>/`), plus `lua/plugins/` for plugin specs and `lua/config/` for per-plugin setup.
- `after/`, `plugin/`: Auto‑loaded configs (keymaps, autocmds) that run after startup.
- `ftplugin/`: Filetype‑specific settings.
- `snippets/`, `queries/`: LSP/snippet and treesitter queries when present.
- `tests/`: Optional headless tests or minimal init for CI.

## Build, Test, and Development Commands
- Install/sync plugins: `nvim --headless "+Lazy sync" +qa` (lazy.nvim) or `nvim --headless -c "PackerSync" -c qa` (packer).
- Health check: `nvim --headless "+checkhealth" +qa` to validate dependencies.
- Format Lua: `stylua lua` (run at repo root).
- Lint Lua: `luacheck lua` (if configured).
- Smoke test: `nvim --headless -u init.lua '+qa'` to ensure clean startup.

## Coding Style & Naming Conventions
- Language: Lua (2 spaces); keep lines ≤ 100 chars.
- Modules: use a clear namespace, e.g., `lua/user/<feature>.lua` and `require("user.<feature>")`.
- Plugin specs: one file per plugin or cohesive group under `lua/plugins/` with descriptive names (e.g., `treesitter.lua`).
- Prefer pure Lua over Vimscript; guard plugin‑specific code with availability checks.
- Run `stylua` before committing; CI may verify formatting.

## Testing Guidelines
- Framework: headless checks via `plenary.nvim` (when available) or simple startup/smoke tests.
- Location: place specs in `tests/` and name `*_spec.lua`.
- Run tests: `nvim --headless -c "PlenaryBustedDirectory tests/ {minimal_init='tests/minimal_init.lua'}" -c qa`.
- Aim for coverage of core modules (mappings, options, plugin configs) and regressions.

## Commit & Pull Request Guidelines
- Commits: concise imperative subject (≤72 chars), body explaining rationale and user impact.
- Scope tags optional: `feat`, `fix`, `refactor`, `docs`, `perf`, `chore`.
- PRs: include summary, screenshots for UI/visual changes, reproduction steps for bugs, and linked issues.
- Keep PRs focused; note any breaking changes and migration notes.

## Security & Configuration Tips
- Avoid committing machine‑specific secrets; prefer `.env`/local files ignored by Git.
- For experimental plugins, disable by default and document enabling steps.

---

# Practical Module Guide with Examples

This configuration is organized around a small set of Lua modules. Use the examples below to confidently add or change behavior by editing the listed files. Paths are relative to `~/.config/nvim`.

## Quick Map of This Repo
- `init.lua` → loads `core` (settings + plugin manager) and then `plugins` (per‑plugin configs).
- `lua/core/settings.lua` → editor options, leaders, simple keymaps.
- `lua/core/plugins.lua` → plugin declarations via vim‑plug.
- `lua/plugins/init.lua` → requires each plugin’s setup module.
- `lua/plugins/*.lua` → per‑plugin configuration (cmp, lsp, luasnip, autopairs, vimtex).
- `lua/LuaSnip/` → custom LuaSnip snippets loaded by `plugins/luasnip.lua`.

If you add a new plugin config file under `lua/plugins/NAME.lua`, also require it in `lua/plugins/init.lua`.

## How To Modify Settings
- Change an editor option or keymap → edit `lua/core/settings.lua`.
- Add/remove a plugin → edit `lua/core/plugins.lua` (add/remove a `Plug(...)` line), then add a config file in `lua/plugins/` and require it in `lua/plugins/init.lua`.
- Adjust LSP, completion, snippets, autopairs, or VimTeX behavior → edit the corresponding file under `lua/plugins/` shown below.

---

## `init.lua` (entry point)
Typical pattern: load core then plugin configs.

```lua
-- ~/.config/nvim/init.lua
require("core")     -- loads core/settings.lua and core/plugins.lua
require("plugins")  -- loads lua/plugins/init.lua which requires each plugin config
```

No changes are usually needed here unless you rename modules.

---

## `lua/core/settings.lua` (options + basic keymaps)
Adjust editor behavior and global keymaps here.

```lua
-- Numbers, tabs/spaces, etc.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false  -- set to true if you prefer spaces

-- Leader keys
vim.g.mapleader = "\\"   -- change to "," or "space" as you like

-- Example: quick save
vim.keymap.set({"n","i"}, "<C-s>", function()
  if vim.api.nvim_get_mode().mode == 'i' then vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>',true,false,true),'n',true) end
  vim.cmd.write()
end, { silent = true, desc = "Save file" })

-- Example: clear search highlighting
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true, desc = "No highlight" })

-- Example: toggle relative number
vim.keymap.set("n", "<leader>rn", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relnumber" })
```

Tips:
- Prefer `vim.keymap.set` with `desc` for discoverability.
- Use `vim.opt_local` inside autocmds for filetype‑specific tweaks (see below).

---

## `lua/core/plugins.lua` (plugins via vim‑plug)
Add or remove plugins here, then run `:PlugInstall` or `:PlugUpdate`.

```lua
-- Start plugin block
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- Example additions
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')  -- optional icons for many UIs

-- Existing plugins (examples kept)
Plug('lervag/vimtex')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')
Plug('rafamadriz/friendly-snippets')
Plug('windwp/nvim-autopairs')

vim.call('plug#end')
```

After adding a plugin here, create its config under `lua/plugins/yourplugin.lua` and require it from `lua/plugins/init.lua`.

---

## `lua/plugins/init.lua` (load per‑plugin configs)
Add a `require` for any new plugin config file you create.

```lua
-- ~/.config/nvim/lua/plugins/init.lua
require("plugins.cmp")
require("plugins.lsp")
require("plugins.luasnip")
require("plugins.autopairs")
require("plugins.vimtex")

-- Example: enable lualine if you added it in core/plugins.lua
-- require("plugins.lualine")
```

---

## `lua/plugins/lsp.lua` (Language Servers)
Add servers and basic settings with `lspconfig`. If you integrate with nvim‑cmp, include capabilities.

```lua
local lspconfig = require('lspconfig')

-- Minimal texlab (existing)
lspconfig.texlab.setup{}

-- Example: lua_ls with nvim-cmp capabilities
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- lspconfig.lua_ls.setup({
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       diagnostics = { globals = { 'vim' } },
--       workspace = { checkThirdParty = false },
--     }
--   }
-- })

-- Example: pyright
-- lspconfig.pyright.setup({ capabilities = capabilities })

-- Example keymaps for LSP (global)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: goto def' })
vim.keymap.set('n', 'K',  vim.lsp.buf.hover,      { desc = 'LSP: hover' })
```

Notes:
- Ensure the server binaries are installed on your system (`texlab`, `lua-language-server`, etc.).
- For custom per‑server settings, pass a table to `.setup{ ... }`.

---

## `lua/plugins/cmp.lua` (Autocomplete)
Change keymaps, sources, or behavior here.

```lua
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Example: limit sources for TeX buffers
cmp.setup.filetype('tex', {
  sources = cmp.config.sources({ { name = 'luasnip' }, { name = 'buffer' } })
})
```

Common edits:
- Change confirm key: edit the `['<CR>']` mapping.
- Add/remove sources: edit `sources` list.

---

## `lua/plugins/luasnip.lua` (Snippets)
Loads custom snippets from `lua/LuaSnip`. Add your own files there and require nothing else.

```lua
local ls = require('luasnip')
require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/lua/LuaSnip' })

ls.config.set_config({
  enable_autosnippets = true,
  store_selection_keys = '<Tab>',
})
```

Add a simple snippet file, e.g. `lua/LuaSnip/tex/formatting.lua`:

```lua
local ls = require('luasnip')
local s, t, i = ls.snippet, ls.text_node, ls.insert_node

return {
  s('bf', { t('\\textbf{'), i(1), t('}') }),
}
```

---

## `lua/plugins/autopairs.lua` (Auto pairs)
Tweak global setup and add rules. Example shows `$...$` rules for TeX/Markdown.

```lua
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
npairs.setup({})

-- Example: add angle brackets in all filetypes
-- npairs.add_rules({ Rule('<', '>') })

-- Existing: smart `$` pairs for TeX/Markdown (see file for details)
```

---

## `lua/plugins/vimtex.lua` (LaTeX tooling)
Adjust compiler/viewer and filetype options here.

```lua
vim.g.vimtex_compiler_method = 'latexmk'    -- or 'tectonic'
vim.g.vimtex_view_method = 'zathura'        -- change to your PDF viewer
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.tex_flavor = 'latex'

-- Per-filetype options
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en'
  end,
})
```

Common edits:
- Change viewer: set `vim.g.vimtex_view_method` to `zathura`, `skim`, `sioyek`, etc.
- Change output dir: add `'-outdir=build'` in `vim.g.vimtex_compiler_latexmk.options`.

---

## Filetype Tweaks (`autocmd` or `ftplugin/`)
For one‑off filetype settings, you can keep using an autocmd (as above). If you prefer `ftplugin`, create `ftplugin/<filetype>.lua` and set local options there. Example `ftplugin/tex.lua`:

```lua
-- ~/.config/nvim/ftplugin/tex.lua
vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en'
```

Neovim auto‑loads this when you open a matching filetype.

---

## Common Tasks (Cheatsheet)
- Add a plugin: edit `lua/core/plugins.lua` (add `Plug()`), then create `lua/plugins/<name>.lua` and require it in `lua/plugins/init.lua`. Run `:PlugInstall`.
- Change a keymap: edit `lua/core/settings.lua` (use `vim.keymap.set`).
- Add a new snippet: drop a file under `lua/LuaSnip/<ft>.lua`; it is auto‑loaded.
- Enable another LSP: add `lspconfig.<server>.setup{}` in `lua/plugins/lsp.lua` (optionally add cmp capabilities).
- Adjust completion behavior: edit mappings or sources in `lua/plugins/cmp.lua`.
- Tweak pairs: edit/add `Rule(...)` in `lua/plugins/autopairs.lua`.
- Change LaTeX viewer/compiler: edit variables in `lua/plugins/vimtex.lua`.

## Validate Changes
- Startup check: `nvim --headless -u init.lua '+qa'`
- Health check: `nvim --headless "+checkhealth" +qa`
- Plug install/update: open Neovim and run `:PlugInstall` or `:PlugUpdate`.

With the above module map and examples, you can confidently modify settings or add features by editing only the indicated files.

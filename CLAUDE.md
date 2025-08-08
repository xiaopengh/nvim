# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a minimal but powerful LaTeX-focused Neovim configuration built with Lua. It provides LaTeX editing capabilities through VimTeX, LSP integration with texlab, autocompletion via nvim-cmp, and snippet support through LuaSnip.

## Architecture

The configuration follows a modular Lua-based architecture:

- **Entry point**: `init.lua` loads core modules
- **Core module**: `lua/core/` contains fundamental settings and plugin declarations
- **Plugin configurations**: `lua/plugins/` contains individual plugin setups
- **Snippets**: `lua/LuaSnip/` contains custom snippet definitions

### Module Structure

- `lua/core/init.lua` - Loads core settings and plugin manager
- `lua/core/settings.lua` - Basic Neovim settings (line numbers, indentation, keybindings)
- `lua/core/plugins.lua` - vim-plug plugin declarations
- `lua/plugins/init.lua` - Loads all plugin configurations
- Individual plugin configs: `cmp.lua`, `lsp.lua`, `luasnip.lua`, `autopairs.lua`, `vimtex.lua`

## Common Development Tasks

### Plugin Management
- Install plugins: `:PlugInstall`
- Update plugins: `:PlugUpdate`
- Clean plugins: `:PlugClean`

### LaTeX Workflow
- Compile LaTeX: `\ll` (VimTeX default)
- View PDF: Automatically opens in Zathura
- Save file: `<Ctrl-s>` (custom keybinding)

### Autocompletion
- Trigger completion: `<Ctrl-Space>`
- Accept completion: `<Enter>`
- Navigate suggestions: `<Tab>` (next), `<Shift-Tab>` (previous)
- Close completion menu: `<Esc>`

### Snippets
- Expand snippet: Type trigger and press `<Tab>`
- Jump to next placeholder: `<Tab>`
- Jump to previous placeholder: `<Shift-Tab>`
- Custom snippets are located in `lua/LuaSnip/`

## Configuration Details

### Plugin Manager
Uses vim-plug for plugin management. All plugins are declared in `lua/core/plugins.lua`.

### LSP Configuration
- texlab LSP server provides LaTeX language features
- Configured in `lua/plugins/lsp.lua` with minimal setup
- Integrates with nvim-cmp for completion

### VimTeX Settings
- Compiler: latexmk with specific options for LaTeX compilation
- PDF viewer: Zathura with forward/backward search
- LaTeX-specific settings: word wrap, spell checking enabled for `.tex` files

### Completion Sources
- LSP completions (texlab)
- LuaSnip snippets
- Buffer words
- File paths
- LaTeX files use snippet-focused completion

### Prerequisites
- Neovim 0.10.0+ (required for LSP compatibility)
- texlab LSP server
- LaTeX distribution (texlive)
- Zathura PDF viewer
- Node.js (for snippet loading)

## File Types and Special Handling

- **LaTeX (.tex)**: Enables spell checking, word wrap, and line breaks; uses texlab LSP
- **Lua**: Main configuration language for this setup
- **Snippets**: Lua-based snippet definitions in `lua/LuaSnip/`
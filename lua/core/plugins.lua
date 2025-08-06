-- ~/.config/nvim/lua/core/plugins.lua

---------------------------------------------------
-- Plugin installation (vim-plug)
---------------------------------------------------
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- VimTeX for LaTeX editing
Plug('lervag/vimtex')

-- Completion engine and snippets
Plug('neovim/nvim-lspconfig')         -- LSP configuration
Plug('hrsh7th/nvim-cmp')              -- Autocompletion engine
Plug('hrsh7th/cmp-nvim-lsp')          -- LSP source for nvim-cmp
Plug('hrsh7th/cmp-buffer')            -- Buffer words source
Plug('hrsh7th/cmp-path')              -- File path source
Plug('L3MON4D3/LuaSnip')              -- Snippet engine
Plug('saadparwaiz1/cmp_luasnip')      -- LuaSnip source for nvim-cmp
Plug('rafamadriz/friendly-snippets')  -- Predefined snippets

-- Automatic pairs of brackets, parentheses, etc.
Plug('windwp/nvim-autopairs')

vim.call('plug#end')


-- ~/.config/nvim/init.lua
-- Neovim minimal LaTeX setup with VimTeX and nvim-cmp (vim-plug)

---------------------------------------------------
-- Plugin installation (vim-plug)
---------------------------------------------------
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- VimTeX for LaTeX editing
Plug('lervag/vimtex')

-- Completion engine and snippets
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')
Plug('rafamadriz/friendly-snippets')

-- Automatic pairs of brackets, parentheses, etc.
Plug('windwp/nvim-autopairs')

vim.call('plug#end')

---------------------------------------------------
-- Basic settings
---------------------------------------------------
vim.g.mapleader = "\\"

-- Quick save keybindings (Ctrl+s)
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

---------------------------------------------------
-- VimTeX configuration
---------------------------------------------------
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.tex_flavor = 'latex'

-- LaTeX-specific editor options
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en'
  end
})

---------------------------------------------------
-- Setup nvim-cmp (autocomplete)
---------------------------------------------------
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
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
  })
})

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()

---------------------------------------------------
-- LSP setup (texlab for LaTeX)
---------------------------------------------------
local lspconfig = require'lspconfig'

lspconfig.texlab.setup{}

---------------------------------------------------
-- Parentheses auto pairing setup
---------------------------------------------------
require('autopairs')   -- autopairs config

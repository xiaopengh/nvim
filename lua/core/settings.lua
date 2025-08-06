-- ~/.config/nvim/lua/core/settings.lua

---------------------------------------------------
-- Basic settings
---------------------------------------------------
vim.g.mapleader = "\\"

-- Quick save keybindings (Ctrl+s)
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

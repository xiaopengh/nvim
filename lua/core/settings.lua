-- ~/.config/nvim/lua/core/settings.lua

---------------------------------------------------
-- Basic settings
---------------------------------------------------
-- Set relative and absolute line numbers
vim.opt.number = true         -- Show absolute line number on the current line
vim.opt.relativenumber = true -- Show relative numbers on other lines

-- Set indentation options
vim.opt.tabstop = 4           -- Number of visual spaces per TAB
vim.opt.shiftwidth = 4        -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4       -- Number of spaces a <Tab> feels like during editing
vim.opt.expandtab = false      -- Convert tabs to spaces


-- Set local leader
vim.g.mapleader = "\\"

-- Quick save keybindings (Ctrl+s)
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

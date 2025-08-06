-- ~/.config/nvim/lua/plugins/lsp.lua

---------------------------------------------------
-- LSP setup (texlab for LaTeX)
---------------------------------------------------
local lspconfig = require('lspconfig')

lspconfig.texlab.setup{}

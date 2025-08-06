-- ~/.config/nvim/lua/plugins/luasnip.lua 

-- LuaSnip setup
local luasnip = require("luasnip")

-- Load Lua-style snippets from custom path
require("luasnip.loaders.from_lua").lazy_load({
  paths = vim.fn.stdpath("config") .. "/lua/LuaSnip",
})

-- Optional: Load VSCode-style snippets (friendly-snippets)
-- require("luasnip.loaders.from_vscode").lazy_load()

-- LuaSnip configuration
luasnip.config.set_config({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",  -- Key to store visual selection for snippets
})

-- Jump forward in insert mode with Tab
vim.keymap.set({ "i" }, "<Tab>", function()
  return require("luasnip").expand_or_jumpable()
      and "<Plug>luasnip-expand-or-jump"
      or "<Tab>"
end, { expr = true, silent = true })

-- Jump forward in select mode with Tab 
local cmp = require('cmp')
vim.keymap.set({ "s" }, "<Tab>", function()
  return require("luasnip").jumpable(1)
      and "<Plug>luasnip-jump-next"
      or "<Tab>"
end, { expr = true, silent = true })

-- Jump backward in insert mode with Shift-Tab
vim.keymap.set("i", "<S-Tab>", function()
  return require("luasnip").jumpable(-1)
      and "<Plug>luasnip-jump-prev"
      or "<S-Tab>"
end, { expr = true, silent = true })

-- Jump backward in select mode with Shift-Tab
vim.keymap.set("s", "<S-Tab>", function()
  return require("luasnip").jumpable(-1)
      and "<Plug>luasnip-jump-prev"
      or "<S-Tab>"
end, { expr = true, silent = true })


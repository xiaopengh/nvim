-- ~/.config/nvim/lua/plugins/cmp.lua

---------------------------------------------------
-- Setup nvim-cmp (autocomplete)
---------------------------------------------------
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),                  -- Manually trigger completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }),       -- Confirm selection
    ['<Tab>'] = cmp.mapping.select_next_item(),              -- Navigate forward
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),            -- Navigate backward

    -- Close the completion menu with <Esc>
    ['<Esc>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Filetype-specific configuration for LaTeX
cmp.setup.filetype("tex", {
  sources = cmp.config.sources({
    { name = "luasnip" },  -- Use only snippets
    { name = "buffer" },   -- and current buffer content
    { name = "path" },  -- Uncomment if needed for \includegraphics etc.
  })
})

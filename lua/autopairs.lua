-- ~/.config/nvim/lua/config/autopairs.lua

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

-- Setup autopairs
npairs.setup({})

-- Integration with nvim-cmp
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- Custom rule: auto-insert $...$ in tex and markdown
npairs.add_rules({
  Rule("$", "$", { "tex", "markdown" })
    :with_pair(function(opts)
      local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
      return prev_char:match("[%s%(%[%{%=%+%-]") ~= nil
    end)
    :with_move(function(opts) return opts.prev_char:match(".%$") ~= nil end)
    :use_key("$")
})

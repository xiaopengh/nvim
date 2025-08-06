-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {

	-- general environment
	s({trig="env", snippetType="autosnippet", dscr="Expand 'env' into a general environment"},
		fmta(
			[[
				\begin{<>}
					<>
				\end{<>}
			]],
			{ i(1), i(2), rep(1) }-- this node repeats insert node i(1)}
		)
	),
	
	-- \frac
	s({trig="ff", dscr="Expands 'tt' into \texttt{}"},
		fmta(
			"\\frac{<>}{<>}",
			{ i(1), i(2) }
		)
	),

	-- Equation
	s({trig="eq", dscr="Expand 'eq' into an equation environment"},
		fmta(
			[[
				\begin{equation*}
					<>
				\end{equation*}
			]],
			{ i(1) }
		)

	)
}

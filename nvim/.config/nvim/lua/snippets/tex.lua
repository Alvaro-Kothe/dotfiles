local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  s("tt", fmta("\\texttt{<>}", { i(1) })),
  s({ trig = "ff", desc = "Expands 'ff' into '\\frac{}{}'" }, fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  s(
    "figure",
    fmta(
      [[
    \begin{figure}
    	\centering
    	\includegraphics[width=0.7\textwidth]{<>}
    	\caption{<>}
    \end{figure}
  ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    "table",
    fmta(
      [[
    \begin{table}
    	\centering
    	\caption{<>}
    	<>
    \end{table}
  ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    "itemize",
    fmta(
      [[
  \begin{itemize}
  	\item <>
  \end{itemize}
  ]],
      { i(1) }
    )
  ),
  s(
    "enumerate",
    fmta(
      [[
  \begin{enumerate}
  	\item <>
  \end{enumerate}
  ]],
      { i(1) }
    )
  ),
  s(
    "env",
    fmta(
      [[
        \begin{<>}
        	<>
        \end{<>}
      ]],
      { i(1), i(2), rep(1) }
    )
  ),
}

return {
  "lervag/vimtex",
  config = function()
    vim.g.vimtex_view_method = "zathura_simple"
    vim.g.vimtex_grammar_textidote = {
      ["jar"] = "~/textidote.jar",
    }
  end,
}

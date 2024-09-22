return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_grammar_textidote = {
      ["jar"] = "~/textidote.jar",
    }
  end,
}

return {
  {
    "lervag/vimtex",
    lazy = false,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
      { "<localleader>C", "<plug>(vimtex-compile-ss)", desc = "Compile", ft = "tex" },
    },
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_grammar_textidote = {
        ["jar"] = "~/textidote.jar",
      }
      vim.g.vimtex_mappings_disable = {
        ["n"] = { "K" },
      }
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "micangl/cmp-vimtex", },
    opts = {
      sources = {
        default = { "vimtex" },
        providers = {
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 100,
          },
        },
      },
    },
  },
}

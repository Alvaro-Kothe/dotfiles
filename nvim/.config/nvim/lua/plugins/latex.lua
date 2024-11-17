return {
  {
    "lervag/vimtex",
    lazy = false,
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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              latexindent = {
                modifyLineBreaks = true,
              },
            },
          },
        },
      },
    },
  },
}

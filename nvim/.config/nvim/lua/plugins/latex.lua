return {
  {
    "lervag/vimtex",
    lazy = false,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
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
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "micangl/cmp-vimtex" },
    opts = function()
      require("cmp").setup.filetype("tex", {
        sources = {
          { name = "vimtex" },
          { name = "buffer" },
          -- other sources
        },
      })
    end,
  },
}

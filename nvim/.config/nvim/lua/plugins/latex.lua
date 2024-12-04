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
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      -- It's inserted with max priority for completion group, may change it with `group_index`
      table.insert(opts.sources, { name = "vimtex" })
    end,
  },
}

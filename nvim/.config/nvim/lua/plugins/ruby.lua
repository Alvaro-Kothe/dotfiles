return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          manual_install = true,
          init_options = {
            formatter = "standard",
            linters = { "standard" },
          },
        },
      },
    },
  },
}

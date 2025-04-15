return {
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = { ensure_installed = { "lua_ls" } },
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}

return {
  {
    "R-nvim/R.nvim",
    lazy = false,
    opts = {
      hook = {
        on_filetype = function()
          local wk = require("which-key")
          wk.add({
            buffer = true,
            mode = { "n", "v" },
            { "<localleader>a", group = "all" },
            { "<localleader>b", group = "between marks" },
            { "<localleader>c", group = "chunks" },
            { "<localleader>f", group = "functions" },
            { "<localleader>g", group = "goto" },
            { "<localleader>i", group = "install" },
            { "<localleader>k", group = "knit" },
            { "<localleader>p", group = "paragraph" },
            { "<localleader>q", group = "quarto" },
            { "<localleader>r", group = "r general" },
            { "<localleader>s", group = "split or send" },
            { "<localleader>t", group = "terminal" },
            { "<localleader>v", group = "view" },
          })
        end,
      },
    },
    config = function(_, opts)
      vim.g.rout_follow_colorscheme = true
      require("r").setup(opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "R-nvim/cmp-r" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "cmp_r" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "r", "rnoweb", "markdown", "yaml" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        r_language_server = {
          cmd = { "R", "--vanilla", "--slave", "-e", "languageserver::run()" },
          manual_install = true,
        },
      },
    },
  },
}

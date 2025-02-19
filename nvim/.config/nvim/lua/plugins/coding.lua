return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "cargo build --release",
    opts_extend = { "sources.default" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    ---@diagnostic disable: missing-fields
    opts = {
      appearance = {
        nerd_font_variant = "normal",
      },
      keymap = {
        preset = "default",
        ["<C-d>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      -- experimental signature help support
      signature = { enabled = true },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { "saghen/blink.compat", version = "*", lazy = true },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cD",
        function() require("neogen").generate() end,
        desc = "Generate Documentation",
      },
    },
    opts = { snippet_engine = "nvim" },
  },
}

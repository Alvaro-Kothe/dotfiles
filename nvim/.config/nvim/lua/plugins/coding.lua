return {
  {
    "saghen/blink.cmp",
    lazy = false,
    build = "cargo build --release",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts_extend = { "sources.default" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    ---@diagnostic disable: missing-fields
    opts = {
      appearance = {
        nerd_font_variant = "normal",
        use_nvim_cmp_as_default = false,
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
      snippets = {
        expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then return require("luasnip").jumpable(filter.direction) end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction) require("luasnip").jump(direction) end,
      },
      sources = {
        default = { "lsp", "path", "luasnip", "buffer", "lazydev" },
        cmdline = {},
        providers = {
          buffer = {
            score_offset = -3,
          },
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
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    build = "make install_jsregexp",
    opts = {},
    config = function(_, opts)
      require("luasnip").config.setup(opts)
      require("luasnip.loaders.from_lua").lazy_load()
    end,
  },
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
    opts = { snippet_engine = "luasnip" },
  },
}

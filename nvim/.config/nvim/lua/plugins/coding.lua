return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
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
      "garymjr/nvim-snippets",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      return {
        completion = { completeopt = "menu,menuone,noinsert" },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item({}),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- scroll the documentation window [d]own / [f]orward
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping.complete({}),

          -- For more advanced luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "snippets" },
          { name = "path" },
        }, {
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end,
            },
          },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            menu = {
              nvim_lsp = "[LSP]",
              snippets = "[snippets]",
              path = "[Path]",
              buffer = "[Buffer]",
              cmp_r = "[R]",
              -- vimtex = "[TeX]",
            },
          }),
        },
      }
    end,
  },
  {
    "garymjr/nvim-snippets",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      friendly_snippets = true,
    },
    keys = {
      {
        "<C-l>",
        function()
          if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function() vim.snippet.jump(1) end)
            return
          end
          return "<C-l>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<C-l>",
        function()
          vim.schedule(function() vim.snippet.jump(1) end)
        end,
        expr = true,
        silent = true,
        mode = "s",
      },
      {
        "<C-h>",
        function()
          if vim.snippet.active({ direction = -1 }) then
            vim.schedule(function() vim.snippet.jump(-1) end)
            return
          end
          return "<C-h>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
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

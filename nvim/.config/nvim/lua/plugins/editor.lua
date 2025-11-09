---@diagnostic disable: inject-field
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      -- Remove clipboard from registers that should be searched
      require("which-key.plugins.registers").registers = '"-:.%/#=_abcdefghijklmnopqrstuvwxyz0123456789'
    end,
    ---@module "which-key"
    ---@type wk.Opts
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function() return require("which-key.extras").expand.buf() end,
          },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Keymaps (which-key)",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    -- branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    },
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        {
          "<leader>,",
          function() builtin.buffers({ sort_mru = true, sort_lastused = true }) end,
          desc = "Switch Buffer",
        },
        { "<leader>pc", builtin.git_commits,               desc = "Checkout Commit" },
        { "<leader>s/", builtin.current_buffer_fuzzy_find, desc = "Search Buffer" },
        { "<leader>sk", builtin.keymaps,                   desc = "[S]earch [K]eymaps" },
        { "<leader>sG", builtin.git_files,                 desc = "[S]earch [G]it Files" },
        { "<leader>sf", builtin.find_files,                desc = "[S]earch [F]iles" },
        { "<leader>sh", builtin.help_tags,                 desc = "[S]earch [H]elp" },
        { "<leader>sw", builtin.grep_string,               desc = "[S]earch current [W]ord" },
        { "<leader>sg", builtin.live_grep,                 desc = "[S]earch by [G]rep" },
        { "<leader>sd", builtin.diagnostics,               desc = "[S]earch [D]iagnostics" },
        { "<leader>sR", builtin.resume,                    desc = "Resume Search" },
        { "<leader>sb", builtin.builtin,                   desc = "Search Builtin Telescope" },
        {
          "<leader>uC",
          function() builtin.colorscheme({ enable_preview = true, previewer = false }) end,
          desc = "Change Colorscheme",
        },
      }
    end,
    opts = function()
      return {
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- Optional dependency
    opts = {},
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      -- Disable autopairs for roxygen2 docs prefix
      npairs.get_rules("'")[1]:with_pair(cond.not_before_text("#"))
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "]b",    "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b",    "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
    },
    opts = {},
  },
  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      scope = {
        -- Don't show underline, so I can read variable names in snake_case
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "lspinfo",
          "checkhealth",
          "help",
          "man",
          "gitcommit",
          "TelescopePrompt",
          "TelescopeResults",
          "''",
          "csv",
        },
      },
    },
  },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    -- See `:help lualine.txt`
    opts = {
      sections = {
        lualine_c = { { "filename", path = 1 } },
      },
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      exclude_filetypes = { "csv" },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = false },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        "<leader>un",
        function() Snacks.notifier.hide() end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>bdd",
        function() Snacks.bufdelete() end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bdo",
        function() Snacks.bufdelete.other() end,
        desc = "Delete Other Buffers",
      },
      {
        "<leader>cR",
        function() Snacks.rename.rename_file() end,
        desc = "Rename File",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
              .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
              :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      {
        "<leader>fe",
        function() require("oil").open_float() end,
        desc = "Open parent directory",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function() require("grug-far").open({ transient = true }) end,
        desc = "Search and Replace",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTelescope" },
    keys = {
      {
        "<leader>sT",
        "<cmd>TodoTelescope keywords=TODO,FIX<cr>",
        desc = "TODO/FIX",
      },
    },
    opts = {},
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    lazy = true,
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.lsp.config("*", {
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      })
    end,
    opts = {},
    keys = function()
      return {
        { "zR", require("ufo").openAllFolds,  desc = "open all folds" },
        { "zM", require("ufo").closeAllFolds, desc = "Close all folds" },
      }
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_filetypes = {
        ["gitsigns-*"] = true,
        gitcommit = true,
        [""] = true,
      }
    },
  },
}

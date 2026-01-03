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
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    opts = {
      keymap = {
        builtin = {
          true,
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          true,
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-q"] = "select-all+accept",
        },
      },
      previewers = {
        builtin = {
          render_markdown = { enabled = false },
        },
      },
    },
    init = function() require("fzf-lua").register_ui_select() end,
    keys = {
      {
        "<leader>,",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Search Files" },
      { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "[S]earch [H]elp" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]earch by [G]rep" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "[S]earch current [W]ord" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume Search" },
      { "<leader>sb", "<cmd>FzfLua builtin<cr>", desc = "Search Builtin" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      -- search
      {
        "<leader>ss",
        "<cmd>FzfLua lsp_document_symbols<cr>",
        desc = "[S]earch Document [S]ymbols",
      },
      {
        "<leader>sS",
        "<cmd>FzfLua lsp_live_workspace_symbols<cr>",
        desc = "[S]earch Workspace [S]ymbols",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
      { "<leader>bdo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
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
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()
    end,
  },
  {
    "tpope/vim-dispatch",
  },
}

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
    branch = "0.1.x",
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
        { "<leader>pc", builtin.git_commits, desc = "Checkout Commit" },
        { "<leader>s/", builtin.current_buffer_fuzzy_find, desc = "Search Buffer" },
        { "<leader>sk", builtin.keymaps, desc = "[S]earch [K]eymaps" },
        { "<leader>sG", builtin.git_files, desc = "[S]earch [G]it Files" },
        { "<leader>sf", builtin.find_files, desc = "[S]earch [F]iles" },
        { "<leader>sh", builtin.help_tags, desc = "[S]earch [H]elp" },
        { "<leader>sw", builtin.grep_string, desc = "[S]earch current [W]ord" },
        { "<leader>sg", builtin.live_grep, desc = "[S]earch by [G]rep" },
        { "<leader>sd", builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
        { "<leader>sR", builtin.resume, desc = "Resume Search" },
        {
          "<leader>uC",
          function() builtin.colorscheme({ enable_preview = true }) end,
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
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {},
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
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
    opts = {},
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
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
        "<leader>gg",
        function() Snacks.lazygit() end,
        desc = "Lazygit",
      },
      {
        "<leader>gf",
        function() Snacks.lazygit.log_file() end,
        desc = "Lazygit Current File History",
      },
      {
        "<leader>gl",
        function() Snacks.lazygit.log() end,
        desc = "Lazygit Log (cwd)",
      },
      {
        "<leader>cR",
        function() Snacks.rename() end,
        desc = "Rename File",
      },
      {
        "<leader>gB",
        function() Snacks.gitbrowse() end,
        desc = "Git Browse",
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
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>fe",
        function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() }) end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>fg",
        function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end,
        desc = "Git explorer",
      },
      {
        "<leader>fb",
        function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end,
        desc = "Buffer explorer",
      },
    },
    deactivate = function() vim.cmd([[Neotree close]]) end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.uv.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require("neo-tree") end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["e"] = { function() require("neo-tree.command").execute({ source = "filesystem" }) end, desc = "filesystem" },
          ["g"] = { function() require("neo-tree.command").execute({ source = "git_status" }) end, desc = "git status" },
          ["O"] = "system_open",
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        end,
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
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
        "]t",
        function() require("todo-comments").jump_next() end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function() require("todo-comments").jump_prev() end,
        desc = "Previous Todo Comment",
      },
      {
        "<leader>sT",
        "<cmd>TodoTelescope keywords=TODO,FIX<cr>",
        desc = "TODO/FIX",
      },
    },
    opts = {},
  },
}

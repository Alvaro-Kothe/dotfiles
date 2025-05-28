return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "html",
        "json",
        "lua",
        "markdown",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      ignore_install = { "latex" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local disabled_filetypes = { "latex" }
          if vim.tbl_contains(disabled_filetypes, lang) then return true end
        end,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = { enable = true },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
    init = function()
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      local on_attach = function(bufnr)
        local disabled_filetypes = { "csv" }
        return not vim.tbl_contains(disabled_filetypes, vim.bo[bufnr].filetype)
      end
      return { max_lines = 3, on_attach = on_attach }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    opts = {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },
      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
    },
    keys = {
      -- Selections
      {
        "af",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Select around function",
      },
      {
        "if",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Select inside function",
      },
      {
        "ac",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Select around class",
      },
      {
        "ic",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Select inside class",
      },
      {
        "as",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals") end,
        mode = { "x", "o" },
        desc = "Select around local scope",
      },

      -- Swaps
      {
        "<leader>a",
        function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end,
        mode = "n",
        desc = "Swap next parameter",
      },
      {
        "<leader>A",
        function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer") end,
        mode = "n",
        desc = "Swap previous parameter",
      },

      -- Moves: next start
      {
        "]f",
        function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Next function start",
      },
      {
        "]c",
        function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Next class start",
      },
      {
        "]a",
        function() require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Next parameter start",
      },

      -- Moves: next end
      {
        "]F",
        function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.inner", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Next function end",
      },
      {
        "]C",
        function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Next class end",
      },
      {
        "]A",
        function() require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Next parameter end",
      },

      -- Moves: previous start
      {
        "[f",
        function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Previous function start",
      },
      {
        "[c",
        function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Previous class start",
      },
      {
        "[a",
        function() require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Previous parameter start",
      },

      -- Moves: previous end
      {
        "[F",
        function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Previous function end",
      },
      {
        "[C",
        function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Previous class end",
      },
      {
        "[A",
        function() require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects") end,
        mode = { "n", "x", "o" },
        desc = "Previous parameter end",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      aliases = {
        ["htmldjango"] = "html",
      },
    },
  },
}

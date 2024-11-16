return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" },
  },
  keys = function()
    local builtin = require("telescope.builtin")
    return {
      { "<leader>sb", builtin.current_buffer_fuzzy_find, desc = "[S]earch [B]uffer" },
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
        function()
          builtin.colorscheme({ enable_preview = true })
        end,
        desc = "Change Colorscheme",
      },
    }
  end,
  opts = {
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
  end,
}

return {
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
}

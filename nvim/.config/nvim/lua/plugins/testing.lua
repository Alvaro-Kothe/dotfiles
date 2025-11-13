return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    opts_extend = { "adapters" },
    opts = function()
      return {
        adapters = {
          require("neotest-python"),
        },
        discovery = {
          enabled = false,
        },
      }
    end,
    keys = {
      { "<leader>t", "", desc = "+test" },
      {
        "<leader>tt",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc = "Run File",
      },
      {
        "<leader>tr",
        function() require("neotest").run.run() end,
        desc = "Run Nearest",
      },
      {
        "<leader>ts",
        function() require("neotest").summary.toggle() end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function() require("neotest").output_panel.toggle() end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>td",
        function() require("neotest").run.run({ strategy = "dap" }) end,
        desc = "Debug Nearest",
      },
    },
  },
}

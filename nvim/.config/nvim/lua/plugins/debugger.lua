return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      { "theHamsta/nvim-dap-virtual-text", opts = {} },

      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
      {
        "<leader>dlr",
        function() require("dap").run_last() end,
        desc = "Rerun Last Session"
      },
      {
        "<F5>",
        function() require("dap").continue() end,
        desc = "continue",
      },
      {
        "<F1>",
        function() require("dap").step_into() end,
        desc = "step into",
      },
      {
        "<F2>",
        function() require("dap").step_over() end,
        desc = "step over",
      },
      {
        "<F3>",
        function() require("dap").step_out() end,
        desc = "step_out",
      },
      {
        "<Leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "toggle breakpoint",
      },
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = "Set Breakpoint",
      },
      {
        "<Leader>dr",
        function() require("dap").repl.toggle() end,
        desc = "toggle repl",
      },
      {
        "<Leader>dlp",
        function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
        desc = "Log message",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
    keys = {
      {
        "<F7>",
        function() require("dapui").toggle() end,
        desc = "Toggle UI",
      },
      {
        "<leader>de",
        function() require("dapui").eval() end,
        mode = { "n", "v" },
        desc = "evaluate",
      },
      {
        "<leader>dE",
        function() require("dapui").eval(vim.fn.input("[DAP] Expression > ")) end,
        desc = "evaluate prompt",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- "delve",
      },
    },
  },
}

return {
  -- NOTE: Yes, you can install new plugins here!
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },

    -- Add your own debuggers here
    { "leoluz/nvim-dap-go", opts = {} },
  },
  keys = {
    { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "continue",
    },
    {
      "<F1>",
      function()
        require("dap").step_into()
      end,
      desc = "step into",
    },
    {
      "<F2>",
      function()
        require("dap").step_over()
      end,
      desc = "step over",
    },
    {
      "<F3>",
      function()
        require("dap").step_out()
      end,
      desc = "step_out",
    },
    {
      "<Leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "toggle breakpoint",
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Set Breakpoint",
    },
    {
      "<Leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "toggle repl",
    },
    {
      "<Leader>dlp",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      desc = "Log message",
    },
    {
      "<F7>",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle UI",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      mode = { "n", "v" },
      desc = "evaluate",
    },
    {
      "<leader>dE",
      function()
        require("dapui").eval(vim.fn.input("[DAP] Expression > "))
      end,
      desc = "evaluate prompt",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
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
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()
    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Custom configuration
    local ok, jsdap_pkg = pcall(require("mason-registry").get_package, "js-debug-adapter")
    if ok then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            jsdap_pkg:get_install_path() .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
      for _, language in ipairs({ "typescript", "javascript" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end
  end,
}

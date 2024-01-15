return {
  -- NOTE: Yes, you can install new plugins here!
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",

    -- Add your own debuggers here
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

    -- Basic debugging keymaps, feel free to change to your liking!
    local map = function(lhs, rhs, desc)
      if desc then
        desc = "[DAP] " .. desc
      end

      vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
    end

    map("<F5>", require("dap").continue, "continue")
    map("<F1>", require("dap").step_into, "step into")
    map("<F2>", require("dap").step_over, "step over")
    map("<F3>", require("dap").step_out, "step_out")
    map("<Leader>db", require("dap").toggle_breakpoint, "toggle breakpoint")
    vim.keymap.set("n", "<leader>dB", function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })
    map("<Leader>dr", require("dap").repl.toggle, "toggle repl")
    map("<Leader>dlp", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, "Log message")
    map("<F7>", dapui.toggle, "Toggle UI")
    map("<leader>de", require("dapui").eval, "evaluate")
    map("<leader>dE", function()
      require("dapui").eval(vim.fn.input("[DAP] Expression > "))
    end, "evaluate prompt")

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()
    require("nvim-dap-virtual-text").setup({})
    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      { "williamboman/mason-lspconfig.nvim" },
    },
    opts = {
      servers = {
        pyright = {},
        ruff = {
          capabilities = {
            hoverProvider = false,
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      local ensure_installed = {}
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
      local servers = opts.servers or {}
      local function setup_server(server)
        local config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, servers[server] or {})
        lspconfig[server].setup(config)
      end

      local mason_servers = require("mason-lspconfig").get_installed_servers()

      for server, config in pairs(servers) do
        -- Use mason-lspconfig to automatically install some servers.
        if not config.manual_install then table.insert(ensure_installed, server) end
        -- If server is not installed by mason, set it up, otherwise will
        -- use mason-lspconfig handlers.
        if not vim.tbl_contains(mason_servers, server) then setup_server(server) end
      end
      require("mason-lspconfig").setup({ ensure_installed = ensure_installed, handlers = { setup_server } })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function() end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}

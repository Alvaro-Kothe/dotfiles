vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
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
}

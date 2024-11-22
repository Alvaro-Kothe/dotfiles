return {
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
}

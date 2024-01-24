return {
  {
    "folke/tokyonight.nvim",
    opts = {},
    lazy = true,
    keys = {
      {
        "<leader>cC",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Change colorscheme",
      },
    },
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}

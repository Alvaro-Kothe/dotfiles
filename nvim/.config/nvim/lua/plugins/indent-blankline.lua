return {
  -- Add indentation guides even on blank lines
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    scope = {
      -- Don't show underline, so I can read variable names in snake_case
      show_start = false,
      show_end = false,
    },
  },
}

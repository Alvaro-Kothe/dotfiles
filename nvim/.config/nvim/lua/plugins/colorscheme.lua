return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function() vim.cmd.colorscheme("catppuccin-macchiato") end,
    ---@module "catppuccin"
    ---@type CatppuccinOptions
    opts = {
      integrations = {
        blink_cmp = true
      }
    },
  },
}

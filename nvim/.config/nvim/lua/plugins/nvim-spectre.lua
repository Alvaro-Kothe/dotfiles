return {
  "nvim-pack/nvim-spectre",
  event = "VeryLazy",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<leader>S",
      function()
        require("spectre").toggle()
      end,
      desc = "Toggle spectre",
    },
  },
}

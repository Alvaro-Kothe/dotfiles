return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = { manual_mode = true },
    config = function(_, opts)
      local project = require("project_nvim")
      project.setup(opts)

      local telescope = require("telescope")
      telescope.load_extension("projects")
    end,
  },
}

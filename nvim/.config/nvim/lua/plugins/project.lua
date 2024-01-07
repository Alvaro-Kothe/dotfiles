local M = {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
}

function M.config()
  local project = require("project_nvim")
  project.setup({
    manual_mode = true,
  })

  local telescope = require("telescope")
  telescope.load_extension("projects")
end

return M

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = { sql = { "sqlfluff" } },
  },
  config = function(_, opts) require("lint").linters_by_ft = opts.linters_by_ft end,
  init = function()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
      end,
    })
  end,
}

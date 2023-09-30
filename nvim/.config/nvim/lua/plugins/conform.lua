local M = {
  'stevearc/conform.nvim',
  opts = {},
}

function M.config()
  local conform = require 'conform'

  conform.setup {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { { 'prettierd', 'prettier' } },
    },
  }

  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args)
      require('conform').format { bufnr = args.buf, lsp_fallback = true }
    end,
  })
end

return M

local M = {
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
}

function M.config()
  require('gitsigns').setup {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      -- Actions
      vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { desc = '[G]it [S]tage hunk' })
      vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { desc = '[G]it [R]eset hunk' })
      vim.keymap.set('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage hunk' })
      vim.keymap.set('v', '<leader>gr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Reset hunk' })
      vim.keymap.set('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
      vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
      vim.keymap.set('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset Buffer' })
      vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview Hunk' })
      vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle Line Blame' })
      vim.keymap.set('n', '<leader>gd', gs.toggle_deleted, { desc = 'Toggle Deleted' })
    end,
  }
end

return M

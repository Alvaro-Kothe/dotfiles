return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = buffer
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "git stage hunk" })
        map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "git reset hunk" })
        map("v", "<leader>ghs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "git stage hunk" })
        map("v", "<leader>ghr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "git reset hunk" })
        map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "git stage buffer" })
        map("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "git undo stage hunk" })
        map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "git reset buffer" })
        map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "git preview hunk" })
        map("n", "<leader>ghb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "git blame line" })
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "git toggle current line blame" })
        map("n", "<leader>ghd", gitsigns.diffthis, { desc = "git diff against index" })
        map("n", "<leader>ghD", function()
          gitsigns.diffthis("~")
        end, { desc = "git diff against last commit" })
        map("n", "<leader>gtd", gitsigns.toggle_deleted, { desc = "git show toggle deleted" })
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    dependencies = { "tpope/vim-rhubarb" },
    keys = {
      {
        "<leader>gs",
        "<cmd>Git<CR>",
        desc = "[G]it [s]tatus",
      },
    },
  },
}

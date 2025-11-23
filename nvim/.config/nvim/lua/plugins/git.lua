return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
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
        map(
          "v",
          "<leader>ghs",
          function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
          { desc = "git stage hunk" }
        )
        map(
          "v",
          "<leader>ghr",
          function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
          { desc = "git reset hunk" }
        )
        map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "git stage buffer" })
        map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "git reset buffer" })
        map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "git preview hunk" })
        map("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end, { desc = "git blame line" })
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "git toggle current line blame" })
        map("n", "<leader>gti", gitsigns.preview_hunk_inline, { desc = "git preview change inline" })
      end,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
    },
    keys = {
      { "<leader>gs", "<cmd>Neogit<cr>",        desc = "Git Status" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Neogit pull<cr>",   desc = "Git Pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>",   desc = "Git Push" },
    },
    cmd = { "Neogit" },
    ---@module "neogit"
    ---@type NeogitConfig
    opts = {
      fetch_after_checkout = true,
      graph_style = "unicode",
      integrations = {
        diffview = false
      },
      builders = {
        NeogitCommitPopup = function(builder)
          builder:option("c", "reedit-message", "", "Reedit previous commit message", { key_prefix = "-" })
        end,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>ghd", "<cmd>DiffviewOpen -uno<cr>",       desc = "git diff against index" },
      { "<leader>ghD", "<cmd>DiffviewOpen HEAD~ -uno<cr>", desc = "git diff against last commit" },
      { "<leader>ghF", "<cmd>DiffviewFileHistory %<cr>",   desc = "File history" },
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = function()
      return {
        hooks = {
          diff_buf_read = function(bufnr)
            -- Change local options in diff buffers
            -- vim.opt_local.wrap = true
            vim.diagnostic.enable(false, { bufnr = bufnr })
          end,
        },
      }
    end,
  },
}

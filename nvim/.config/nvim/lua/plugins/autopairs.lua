return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  -- Optional dependency
  dependencies = { "hrsh7th/nvim-cmp" },
  opts = {},
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    -- Disable autopairs for roxygen2 docs prefix
    npairs.get_rules("'")[1]:with_pair(cond.not_before_text("#"))
  end,
}

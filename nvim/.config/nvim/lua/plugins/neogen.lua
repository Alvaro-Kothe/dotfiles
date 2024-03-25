return {
  "danymat/neogen",
  keys = {
    {
      "<leader>dg",
      function()
        require("neogen").generate()
      end,
      desc = "[D]ocument [G]enerate",
    },
  },
  opts = { snippet_engine = "luasnip" },
}

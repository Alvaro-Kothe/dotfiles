return {
  "danymat/neogen",
  keys = {
    {
      "<leader>cD",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Documentation",
    },
  },
  opts = { snippet_engine = "luasnip" },
}

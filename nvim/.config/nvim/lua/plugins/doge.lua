return {
  "kkoomen/vim-doge",
  build = ":call doge#install()",
  lazy = false,

  config = function()
    vim.g.doge_enable_mappings = 0
    vim.g.doge_mapping = "<leader>dg"

    -- Generate comment for current line.
    vim.keymap.set("n", "<leader>dg", "<Plug>(doge-generate)")
    -- Interactive mode comment todo-jumping.
    vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
    vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
    vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
    vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
    vim.keymap.set("s", "<TAB>", "<Plug>(doge-comment-jump-forward)")
    vim.keymap.set("s", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
  end,
}

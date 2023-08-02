-- [[ Basic Keymaps ]]
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap('i', 'jk', '<ESC>', opts)

-- window Navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Buffer
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)
keymap('n', '<S-q>', '<cmd>bdelete!<CR>', opts)

-- Visual indent
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Keymaps for better default experience
-- See `:help keymap.set()`
keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Neotree
keymap('n', '<leader>fe', ':Neotree toggle  reveal_force_cwd<cr>', opts)

-- <F1> help
vim.keymap.set('n', '<F3>', ':set nu! rnu!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', ':set list! list?<CR>', { noremap = false, silent = true })
-- <F7> Yazi
vim.keymap.set('n', '<leader>nm', ':Dispatch npm start<CR>', { noremap = false, silent = true })
-- Diff
vim.keymap.set('n', '<leader>dd', ':windo diffthis<CR>', { noremap = false, silent = true })
-- LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })



-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

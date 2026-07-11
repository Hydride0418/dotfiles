-- save without leaving the current mode
vim.keymap.set({ 'n', 'i', 'x' }, '<C-s>', '<Cmd>write<CR>', { desc = 'Save' })
-- Ctrl-r normally means redo; keep that action available on Space+r
vim.keymap.set('n', '<leader>r', '<C-r>', { desc = 'Redo' })
-- quit the current window, prompting when there are unsaved changes
vim.keymap.set('n', '<C-r>', '<Cmd>confirm quit<CR>', { desc = 'Quit' })
-- select all
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select All' })
-- pasting over a selection no longer clobbers your clipboard
vim.cmd([[ xnoremap <expr> p 'pgv"'.v:register.'y' ]])

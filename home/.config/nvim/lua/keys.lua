-- save and quit from normal mode
vim.keymap.set('n', 'S', '<Cmd>write<CR>', { desc = 'Save' })
vim.keymap.set('n', 'R', '<Cmd>confirm quit<CR>', { desc = 'Quit' })
-- keep the original S (change line) and R (replace mode) commands available
vim.keymap.set('n', '<leader>S', 'S', { desc = 'Change Line' })
vim.keymap.set('n', '<leader>R', 'R', { desc = 'Replace Mode' })
-- select all
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select All' })
-- pasting over a selection no longer clobbers your clipboard
vim.cmd([[ xnoremap <expr> p 'pgv"'.v:register.'y' ]])

-- save and quit from normal mode
vim.keymap.set('n', 'S', '<Cmd>write<CR>', { desc = 'Save' })
vim.keymap.set('n', 'R', '<Cmd>confirm quit<CR>', { desc = 'Quit' })
-- keep the original S (change line) and R (replace mode) commands available
vim.keymap.set('n', '<leader>S', 'S', { desc = 'Change Line' })
vim.keymap.set('n', '<leader>R', 'R', { desc = 'Replace Mode' })
-- move directly between split windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window Left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window Down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window Up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window Right' })
-- keep visual selections active while changing indentation
vim.keymap.set('x', '>', '>gv', { desc = 'Indent Right' })
vim.keymap.set('x', '<', '<gv', { desc = 'Indent Left' })
-- keep search results and half-page scrolling centered
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next Search Result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous Search Result' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half Page Down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half Page Up' })
-- select all
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select All' })
-- pasting over a selection no longer clobbers your clipboard
vim.cmd([[ xnoremap <expr> p 'pgv"'.v:register.'y' ]])

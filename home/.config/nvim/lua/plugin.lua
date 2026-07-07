local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local lazy_init = lazypath .. '/lua/lazy/init.lua'

if not vim.uv.fs_stat(lazy_init) then
  vim.fn.delete(lazypath, 'rf')
  local output = vim.fn.system({ 'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
  if vim.v.shell_error ~= 0 then
    error('Failed to install lazy.nvim:\n' .. output)
  end
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')  -- load every file in lua/plugins/

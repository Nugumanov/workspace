-- lua/mappings.lua
vim.keymap.set('v', '<C-c>', ':w !pbcopy<CR><CR>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.api.nvim_set_keymap('n', '<C-g>', ':0G<CR>', { noremap = true, silent = true })

-- Colorscheme cycle mappings
local colors = vim.fn.getcompletion('', 'color')
local function NextColors()
  local idx = vim.fn.index(colors, vim.g.colors_name)
  return (idx + 1 >= #colors) and colors[1] or colors[idx + 1]
end
vim.keymap.set('n', '<F2>', function() vim.cmd('colorscheme ' .. NextColors()) end)

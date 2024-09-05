-- lua/plugin-config/fern.lua
vim.g.fern_disable_default_mappings = 1
vim.g.fern_default_hidden = 1

local function SetupVimLayout()
  vim.cmd('Fern . -drawer -toggle -width=35 -reveal=%')
  vim.cmd('wincmd l')
end

vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = SetupVimLayout,
})

local function fern_settings()
  vim.api.nvim_buf_set_keymap(0, 'n', 'V', '<Plug>(fern-action-open:vsplit)', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<Plug>(fern-action-open:split)', { noremap = true, silent = true })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fern",
  callback = fern_settings,
})

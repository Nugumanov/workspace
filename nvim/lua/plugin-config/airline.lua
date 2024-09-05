-- lua/plugin-config/airline.lua
vim.g.airline_theme = 'gruvbox'

local function AirlineBuffMove()
  vim.g.airline_section_b = '%{getcwd()}'
end

vim.api.nvim_create_augroup('BuffConfig', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'BuffConfig',
  callback = AirlineBuffMove
})

-- lua/autocmds.lua
vim.api.nvim_create_autocmd({"InsertEnter", "InsertLeave"}, {
  pattern = '*',
  command = 'set cul!'
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = "*",
  command = "setlocal number relativenumber"
})

vim.api.nvim_create_autocmd({"BufLeave"}, {
  pattern = "*",
  command = "setlocal nonumber norelativenumber"
})

-- lua/colors.lua

vim.g.gruvbox_italic = 0

-- Check if 'gruvbox' is installed, otherwise use a fallback
local colorscheme = "gruvbox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  -- If 'gruvbox' isn't available, use a default colorscheme as a fallback
  vim.cmd [[colorscheme default]]
end

-- Automatically apply 'gruvbox' after PackerSync completes
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd User PackerComplete ++once lua vim.cmd("colorscheme gruvbox")
  augroup end
]]
--TEST

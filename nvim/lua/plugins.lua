-- lua/plugins.lua

local fn = vim.fn

-- Automatically install packer if not installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
  print("Installing Packer, close and reopen Neovim...")
  vim.cmd [[packadd packer.nvim]]
end

-- Safely require Packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Packer not found, make sure it's installed.")
  return
end

-- Start Packer with plugins
packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Add your plugins here
  use 'sheerun/vim-polyglot'
  use 'lambdalisue/fern.vim'
  use 'yuki-yano/fern-preview.vim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'morhetz/gruvbox'
  use 'roman/golden-ratio'
  use 'rust-lang/rust.vim'
  use 'knubie/vim-kitty-navigator'
  use 'tpope/vim-fugitive'  -- Ensure vim-fugitive is here

  -- Auto-sync if Packer was just installed
  if packer_bootstrap then
    require('packer').sync()
  end
end)

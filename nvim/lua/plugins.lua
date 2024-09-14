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

  -- Coding
  -- Completion framework:
  use 'rust-lang/rust.vim'
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  --use 'hrsh7th/nvim-cmp'
  -- LSP completion source:
  --use 'hrsh7th/cmp-nvim-lsp'
  -- Useful completion sources:
  --use 'hrsh7th/cmp-nvim-lua'
  --use 'hrsh7th/cmp-nvim-lsp-signature-help'
  --use 'hrsh7th/cmp-vsnip'
  --use 'hrsh7th/cmp-path'
  --use 'hrsh7th/cmp-buffer'
  --use 'hrsh7th/vim-vsnip'

  --use 'nvim-treesitter/nvim-treesitter'

  -- Add your plugins here
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  
  use 'sheerun/vim-polyglot'
  use 'lambdalisue/fern.vim'
  use 'yuki-yano/fern-preview.vim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'morhetz/gruvbox'
  use 'roman/golden-ratio'
  use 'knubie/vim-kitty-navigator'
  use 'tpope/vim-fugitive'  -- Ensure vim-fugitive is here

  -- Auto-sync if Packer was just installed
  if packer_bootstrap then
    require('packer').sync()
  end
end)

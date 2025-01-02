local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  
  use {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
	     require('telescope').setup {
	     }
      end
  }

  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
	  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
	  ts_update()
      end
  }

  use {
      'akinsho/bufferline.nvim',
      tag = "*",
      requires = 'nvim-tree/nvim-web-devicons'
  }

  use 'neovim/nvim-lspconfig' 		 	-- Language server protocol  
  use 'williamboman/mason.nvim'          	-- LSP server manager
  use 'williamboman/mason-lspconfig.nvim' 	-- Bridges Mason with lspconfig
  use 'hrsh7th/nvim-cmp'                 	-- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'             	-- LSP source for nvim-cmp

  use 'mfussenegger/nvim-dap'           	-- Core debugging plugin
  
  use {                                         -- UI enhancements for nvim-dap
	  'rcarriga/nvim-dap-ui',           
	  requires = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }
  }

  use 'theHamsta/nvim-dap-virtual-text' 	-- Virtual text for debug information

  use 'shaunsingh/nord.nvim'

  use 'tpope/vim-fugitive'

  use  "lewis6991/gitsigns.nvim"

  use "nvim-tree/nvim-tree.lua"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

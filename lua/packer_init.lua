-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)


  -- Essential plugins
  use 'wbthomason/packer.nvim'

  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      config = function() require("telescope").load_extension("mapper") require("telescope").load_extension "file_browser" end
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require('hop').setup {  }
    end
  }


  -- copilot
  use {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function ()
      vim.schedule(function()
        require("copilot").setup()
      end)
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }


  -- R BS
  use {
      'folke/neodev.nvim',
      config = function()
          require('neodev').setup()
      end,
  }
  use {'jalvesaq/Nvim-R'}
  use {
      'lukas-reineke/headlines.nvim',
      config = function()
          require('headlines').setup()
      end,
  }
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'


  use 'tpope/vim-vinegar'

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'
  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }


  -- Latex support
  use 'lervag/vimtex'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  use 'preservim/nerdtree'

  -- Tag viewer
  use 'preservim/tagbar'


  -- Color schemes
  use 'navarasu/onedark.nvim'
  use 'tanvirtin/monokai.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }


  use {
      "lazytanuki/nvim-mapper",
      config = function() require("nvim-mapper").setup{} end,
      before = "telescope.nvim"
  }

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- Obsidian


  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  }
  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }


  -- git
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup{}
    end
  }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".obsidian" },
      }
    end
  }

  -- QOL
  use {
    'lewis6991/impatient.nvim',
    config = function()
      require("impatient").enable_profile()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- terminal support
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup({
      size = 10,
      open_mapping = [[<localleader>t]],
      shading_factor = 2,
      direction = "tab",
    })
    end}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

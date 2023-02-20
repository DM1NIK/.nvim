--[[
-
Neovim init file
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]

-- Import Lua modules
require('packer_init')
require('core/options')
require('core/autocmds')
require('core/keymaps')
require('core/colors')
require('core/statusline')
require('lsp/lspconfig')
require('plugins/indent-blankline')
require('plugins/nvim-cmp')
require('plugins/alpha-nvim')
require('plugins/mason')
require('plugins/telescope')
require('plugins/nvim-treesitter')


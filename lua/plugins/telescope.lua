
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local fb_actions = require "telescope".extensions.file_browser.actions
require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true}
  },
  defaults = {
    mappings = {
      n = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<S-c>'] = fb_actions.create,
        ['<S-d>'] = fb_actions.remove,
        ['<S-r>'] = fb_actions.rename,
        ['<S-o>'] = fb_actions.open,
      },
    },
    extensions = {
      file_browser = {
        hijack_netrw = true,
      },
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf');
pcall(require('telescope').load_extension, 'file_browser');
pcall(require('telescope').load_extension, 'projects');


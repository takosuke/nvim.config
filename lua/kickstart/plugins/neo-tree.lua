-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<C-n>', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  config = function()
    require('neo-tree').setup {
      window = {
        position = 'left',
        width = 30,
        mappings = {
          ['\\'] = 'close_window',
          ['<space>'] = 'none',
          ['d'] = 'delete',
          ['o'] = 'open',
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
    }
  end,
}

return {
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = 'Git: File History (Cycle Versions)' },
    },
    config = true,
  },
}

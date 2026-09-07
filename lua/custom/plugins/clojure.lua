local clojure_fts = { 'clojure', 'edn' }

return {
  -- REPL integration
  {
    'Olical/conjure',
    ft = clojure_fts,
    init = function()
      vim.g['conjure#log#hud#enabled'] = false
    end,
  },

  -- Structural editing
  {
    'julienvincent/nvim-paredit',
    ft = clojure_fts,
    opts = {
      use_default_keys = true,
      filetypes = clojure_fts,
    },
    config = function(_, opts)
      require('nvim-paredit').setup(opts)
      -- Disable autopairs for clojure so paredit owns the parens
      vim.api.nvim_create_autocmd('FileType', {
        pattern = clojure_fts,
        callback = function()
          local ok, autopairs = pcall(require, 'nvim-autopairs')
          if ok then
            autopairs.disable()
          end
        end,
      })
    end,
  },
}

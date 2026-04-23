-- Sauvegarde + restauration automatique des sessions (buffers, splits, cursor).
-- Relancer nvim dans un projet et retrouver l'état exact d'avant.
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    {
      '<leader>ps',
      function()
        require('persistence').load()
      end,
      desc = '[P]ersistence re[s]tore session',
    },
    {
      '<leader>pl',
      function()
        require('persistence').load { last = true }
      end,
      desc = '[P]ersistence load [l]ast session',
    },
    {
      '<leader>pq',
      function()
        require('persistence').stop()
      end,
      desc = "[P]ersistence [q]uit — don't save this one",
    },
  },
}

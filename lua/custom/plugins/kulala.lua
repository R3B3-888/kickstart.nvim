-- Client REST intégré pour tester des endpoints FastAPI sans quitter nvim.
-- Créer un fichier `.http` et lancer la requête avec <leader>rr.
return {
  'mistweaverco/kulala.nvim',
  ft = { 'http', 'rest' },
  opts = {},
  keys = {
    {
      '<leader>rr',
      function()
        require('kulala').run()
      end,
      desc = 'Kulala: [R]un [R]equest',
      ft = { 'http', 'rest' },
    },
  },
}

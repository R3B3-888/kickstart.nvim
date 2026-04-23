-- Client DB (Postgres, MySQL, SQLite, Redis...) avec UI type DBeaver.
-- Configurer les connexions : `:DBUIAddConnection` ou via ~/.local/share/db_ui/.
return {
  { 'tpope/vim-dadbod', cmd = 'DB' },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    dependencies = {
      'tpope/vim-dadbod',
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      { '<leader>du', '<cmd>DBUIToggle<cr>', desc = '[D]B [U]I toggle' },
    },
  },
}

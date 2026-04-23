-- LazyGit UI: branches, log, rebase interactif, merge, stash...
-- Requiert le binaire `lazygit` installé sur le système (apt, brew, ou binaire GitHub).
return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = '[G]it UI (lazy[g]it)' },
  },
}

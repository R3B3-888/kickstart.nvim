-- Rendu markdown inline dans nvim (headings stylés, checkboxes, tableaux,
-- code blocks surlignés). Zéro serveur externe.
return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}

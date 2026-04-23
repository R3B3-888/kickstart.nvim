-- Runner de tests inline : pytest (Python) + vitest (TS/React).
-- Symboles ✓/✗ dans la gutter, summary pane, output sous le curseur.
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/nvim-nio',
    'nvim-neotest/neotest-python',
    'marilari88/neotest-vitest',
  },
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = '[T]est nearest',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[T]est [f]ile',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = '[T]est [l]ast',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true }
      end,
      desc = '[T]est [o]utput',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[T]est [s]ummary',
    },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python',
        require 'neotest-vitest',
      },
    }
  end,
}

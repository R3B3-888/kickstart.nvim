-- Adapters DAP par langage. Le moteur nvim-dap est chargé via
-- lua/kickstart/plugins/debug.lua ; ce fichier ajoute les backends.
--
-- Python : utilise debugpy installé par Mason.
-- JS/TS  : utilise js-debug-adapter installé par Mason (via mason-tool-installer
--          dans init.lua).
return {
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local debugpy = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(debugpy)
    end,
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
        adapters = { 'pwa-node', 'pwa-chrome', 'node', 'chrome' },
      }
    end,
  },
}

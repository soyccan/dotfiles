-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("__organize_imports_python", { clear = true }),
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" }, diagnostics = {} } })
    -- vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports" }, diagnostics = {} } })
    -- vim.lsp.buf.code_action({ apply = true, context = { only = { "source.unusedImport" }, diagnostics = {} } })
  end,
})

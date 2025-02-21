-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Editor
vim.opt.colorcolumn = "100"

-- Disable autoformat
-- to manually format:
--   :lua vim.lsp.buf.format()
--   :lua require("conform").format()
--   :ConformFormat
vim.g.autoformat = false

-- Disable animation
-- vim.g.snacks_animate = false

-- Disable smooth scrolling for all versions
-- if vim.fn.has("nvim-0.10") == 1 then
--   vim.opt.smoothscroll = false
-- end

-- Python
vim.g.lazyvim_python_lsp = "ruff"

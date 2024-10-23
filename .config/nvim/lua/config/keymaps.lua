-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- move around the current line
-- inspired by Helix
vim.keymap.set({ "n", "v", "o" }, "gh", "0", { desc = "goto line start" })
vim.keymap.set({ "n", "v", "o" }, "gl", "$", { desc = "goto line end" })
vim.keymap.set({ "n", "v", "o" }, "gs", "^", { desc = "goto first non-whitespace of the line" })

-- editing
vim.keymap.set("n", "<cr>", "o<esc>", { desc = "Insert blank line" })

-- quit
vim.keymap.set({ "n", "v" }, "q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set({ "n", "v" }, "qq", "<cmd>qa<cr>", { desc = "Quit all" })
-- remap the native function of q to Ctrl-q
vim.keymap.set({ "n", "v" }, "<c-q>", "q", { desc = "Start recording macro" })
-- inspired by ZZ
vim.keymap.set({ "n", "v" }, "Z", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- move around the current line
-- inspired by Helix
vim.keymap.set({ "n", "v", "o" }, "gh", "0", { desc = "Goto Line Start" })
vim.keymap.set({ "n", "v", "o" }, "gl", "$", { desc = "Goto Line End" })
vim.keymap.set({ "n", "v", "o" }, "gs", "^", { desc = "Goto First Non-Whitespace in the Line" })

-- editing
vim.keymap.set("n", "<cr>", "o<esc>", { desc = "Insert Blank Line" })
vim.keymap.set({ "i", "v" }, "`", "<esc>", { desc = "Return to Normal Mode" })

-- quit
vim.keymap.set({ "n", "v" }, "q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set({ "n", "v" }, "Q", "<cmd>qa<cr>", { desc = "Quit All" })
-- remap the native function of q
vim.keymap.set({ "n", "v" }, "<leader>qr", "q", { desc = "Start Recording Macro" })
-- inspired by ZZ
vim.keymap.set({ "n", "v" }, "Z", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Set leader key to space BEFORE defining any mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- for conciseness

-- General Keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Exit insert mode with jj
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })


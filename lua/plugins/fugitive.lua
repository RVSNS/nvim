return {
  "tpope/vim-fugitive",
  cmd = { "Git", "Gdiffsplit", "Gclog", "Gread", "Gwrite", "Gblame" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
  },
}

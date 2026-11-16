return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer tab" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
    { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close buffer" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        { filetype = "NvimTree", text = "Explorer", highlight = "Directory", text_align = "left" },
      },
    },
  },
}

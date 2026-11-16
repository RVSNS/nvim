return {
  "saghen/blink.cmp",
  version = "1.*", -- pulls prebuilt binary release, no Rust toolchain needed
  event = "InsertEnter",
  opts = {
    keymap = { preset = "default" },
    completion = {
      documentation = { auto_show = true },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}

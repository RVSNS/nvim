return {
  {
    "mason-org/mason.nvim",
    opts = {}, -- Required: initializes Mason and adds its bin/ folder to Neovim's PATH
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "tree-sitter-cli",    -- Needed by nvim-treesitter to compile grammars
        "gopls",              -- Go language server (LSP)
        "gofumpt",            -- Stricter Go formatter
        "goimports",          -- Auto-manages Go import lines
        "golangci-lint",      -- Fast Go linter aggregator
        "delve",              -- Go debugger (DAP)
        "lua-language-server", -- Lua language server (LSP), for editing this config
        "stylua",             -- Lua formatter
        "shfmt",              -- Shell script formatter
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}

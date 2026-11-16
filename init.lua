require("core.options")
require("core.keymaps")

-- Disable unused remote-plugin providers (no plugin here uses them)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim to load plugins from lua/plugins/
require("lazy").setup({
  spec = { { import = "plugins" } },
  rocks = { enabled = false },
})

-- Native LSP config (depends on Mason having put server bins on PATH above)
require("core.lsp")

local opt = vim.opt
local api = vim.api

-- Line numbers
opt.number = true                   -- Show absolute line number
opt.relativenumber = true           -- Show relative line numbers

-- Tabs & Indentation
opt.tabstop = 4                     -- 2 spaces for tabs (good default for Lua/web dev)
opt.shiftwidth = 4                  -- 2 spaces for indent width
opt.expandtab = true                -- Expand tab to spaces
opt.autoindent = true               -- Copy indent from current line when starting new one

-- Search settings
opt.ignorecase = true               -- Ignore case when searching
opt.smartcase = true                -- If you include mixed case in search, assumes you want case-sensitive

-- Appearance
opt.termguicolors = true            -- True color support
opt.signcolumn = "yes"              -- Show sign column so that text doesn't shift

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard for yank/paste

-- Disable carrying of comment characters to a new line when pressing Enter
api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- Disable swap files
opt.swapfile = false

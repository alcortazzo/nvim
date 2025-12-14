-- Display line numbers (absolute and relative)
vim.opt.number = true                      -- Show absolute line number on cursor line
vim.opt.relativenumber = true              -- Show relative line numbers elsewhere

-- Use system clipboard for all yank, delete, change, and put operations
vim.opt.clipboard:append("unnamedplus")    -- Allow access to system clipboard

-- Highlight yanked text for a short time
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 }
  end,
})

-- Search settings
vim.opt.ignorecase = true                  -- Case insensitive search by default
vim.opt.smartcase = true                   -- Case sensitive if search pattern contains uppercase

-- Cursor and screen behavior
vim.o.cursorline = true                    -- Highlight current line
vim.o.scrolloff = 10                       -- Minimum lines above/below cursor

-- Invisible character display
vim.opt.list = true                        -- Show invisible characters
vim.opt.listchars = { tab = "▸ ", trail = "·", space = "·" }

-- Confirm dialog on actions if buffer has unsaved changes
vim.o.confirm = true                       -- Prompt to save unsaved files on quit

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')                   -- <Esc> clears search highlight
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true }) -- Tab indents visually selected text
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true }) -- Shift+Tab outdents visually selected text
vim.keymap.set('n', '<Tab>', ':bnext<CR>')         -- Next buffer
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>')   -- Previous buffer

-- Indentation
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.tabstop = 4             -- Number of spaces tabs count for
vim.opt.shiftwidth = 4          -- Number of spaces for each indentation
vim.opt.softtabstop = 4         -- Number of spaces per Tab in insert mode

-- Display
-- vim.opt.wrap = false            -- Don't wrap long lines
vim.opt.termguicolors = true    -- Enable true color support
vim.opt.signcolumn = "yes"      -- Always show signcolumn

-- Splits
vim.opt.splitright = true       -- Vertical splits open to the right
vim.opt.splitbelow = true       -- Horizontal splits open below

-- Performance
vim.opt.updatetime = 300        -- Faster completion (?) (default is 4000ms)

-- Leader keys (set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})



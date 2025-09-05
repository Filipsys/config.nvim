vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("vert Lexplore!")
end)

vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

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
    {
      "catppuccin/nvim",
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    }
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "javascript", "typescript", "python", "html", "css" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
}

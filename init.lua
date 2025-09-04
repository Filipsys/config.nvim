vim.g.mapleader = " "

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.number = true
vim.o.ruler = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("Lexplore!")
end)

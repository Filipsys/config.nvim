vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.scrolloff = 8

vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.o.timeoutlen = 3000

-- Keymaps
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("vert Lexplore!")
end)
vim.keymap.set("n", "<leader>r", vim.cmd.UndotreeToggle)
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Multi-line macros
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.keymap.set("v", "<leader>javac",  "yoSystem.out.println(\"" .. esc .. "pa: \" + " .. esc .. "pa);" .. esc)
vim.keymap.set("v", "<leader>jsc", "yoconsole.log(\"" .. esc .. "pa: \", " .. esc .. "pa);")

-- Functions
vim.api.nvim_create_user_command("Ask", function(opts)
  vim.notify("Fetching message...", vim.log.levels.INFO)

  vim.fn.jobstart({
    "curl", "--get", "-s", "https://ai.filyys.dev/ask",
    "--data-urlencode", "k=1313",
    "--data-urlencode", "q=" .. table.concat(opts.fargs, " "),
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data and #data <= 0 then return end
        vim.api.nvim_put(data, "l", true, true)

        vim.notify("Done.", vim.log.levels.INFO)
        vim.defer_fn(function() vim.notify("", vim.log.levels.INFO) end, 3000)
    end,
  })
end, { nargs = "+" })

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
      "mbbill/undotree",
      "nvim-treesitter/nvim-treesitter",
      'numToStr/Comment.nvim',
      "saghen/blink.cmp",
      "neovim/nvim-lspconfig",
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

-- Setup Comment.nvim
require('Comment').setup()

-- Setup LSP
require("lazy").setup("lsp")
require("lsp-config")

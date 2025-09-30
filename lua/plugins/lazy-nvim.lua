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

require("lazy").setup({
  spec = {
    {
      "slugbyte/lackluster.nvim",
      "mbbill/undotree",
      "nvim-treesitter/nvim-treesitter",
      "numToStr/Comment.nvim",
      "rafamadriz/friendly-snippets",
      "saghen/blink.cmp",
      build = ":TSUpdate"
    },
    {
      "mason-org/mason.nvim",
      opts = {}
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {"lua_ls", "ts_ls", "java-language-server",
                            "html-lsp", "cssls"},
        automatic_installation = true,
      }
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
          "force", lspconfig.util.default_config.capabilities, capabilities
        )
      end,
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        preset = "helix",
        delay = 0,

        win = {
          title = false,
          border = "none",
          padding = { 0, 0 },

          wo = { winblend = 100 },
        },

        icons = {
          mappings = false,
          separator = "",
        },
      },
    }
  },
  install = {},
  checker = { enabled = true },
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.scrolloff = 8

vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.o.incsearch = true
vim.o.hlsearch = false

vim.o.updatetime = 50
vim.o.timeoutlen = 3000

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Undotree config
vim.keymap.set("n", "<leader>r", vim.cmd.UndotreeToggle)
if vim.fn.has("persistent_undo") == 1 then
  local target_path = vim.fn.expand("~/.undodir")

  if vim.fn.isdirectory(target_path) == 0 then
    vim.fn.mkdir(target_path, "p", 448)
  end
  vim.o.undodir = target_path
  vim.o.undofile = true
end

-- Keymaps
vim.keymap.set("n", "<leader>e", function() vim.cmd("vert Lexplore!") end)
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Multi-line macros
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.keymap.set("v", "<leader>javac",  "yoSystem.out.println(\"" .. esc .. "pa: \" + " .. esc .. "pa);" .. esc)
vim.keymap.set("v", "<leader>jsc", "yoconsole.log(\"" .. esc .. "pa: \", " .. esc .. "pa);")

-- Events
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end
})

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
        ensure_installed = {"lua_ls", "tsserver", "java-language-server",
                            "vscode-html-languageserver", "vscode-css-languageserver"},
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

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "java", "javascript", "typescript", "python", "html", "css" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
})

-- Setup Comment.nvim
require("Comment").setup()

-- Blink.cmp
require("blink.cmp").setup({
  fuzzy = { implementation = "lua" },

  completion = {
    trigger = {
      show_on_keyword = true,
      show_on_trigger_character = true,
      show_on_insert_on_trigger_character = true,
      show_on_insert = false,

      show_on_backspace = false,
      show_on_backspace_in_keyword = false,
    },

    list = { selection = { preselect = false, auto_insert = false } },

    menu = {
      auto_show = true,

      draw = {
        columns = { { "label", "label_description", gap = 0 } }
      },
    },

    ghost_text = { enabled = false },
    -- documentation = { auto_show = true, auto_show_delay_ms = 200 },
  },


  appearance = {
    nerd_font_variant = "normal",

    kind_icons = {
      Text        = "",
      Method      = "",  
      Function    = "",  
      Constructor = "",
      Field       = "",
      Variable    = "",
      Class       = "",
      Interface   = "",
      Module      = "",
      Property    = "",
      Unit        = "",
      Value       = "",
      Enum        = "",
      Keyword     = "",
      Snippet     = "",
      Color       = "",
      File        = "",
      Reference   = "",
      Folder      = "",
      EnumMember  = "",
      Constant    = "",
      Struct      = "",
      Event       = "",
      Operator    = "",
      TypeParameter = "",
    },
  },

  sources = { default = { "lsp", "path", "buffer", "snippets" } },
})

-- Small theme tweaks 
vim.cmd("color lackluster")
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#717171", bg = "NONE" })

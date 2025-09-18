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

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.keymap.set("v", "<leader>javac",  "yoSystem.out.println(\"" .. esc .. "pa: \" + " .. esc .. "pa);" .. esc)
vim.keymap.set("v", "<leader>jsc", "yoconsole.log(\"" .. esc .. "pa: \", " .. esc .. "pa);")

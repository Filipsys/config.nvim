vim.keymap.set("v", "<leader>javac",  "yoSystem.out.println(\"<Esc>pa: \" + <Esc>pa);<Esc>", { desc = "[java] Print out the selected variable on a new line" })
vim.keymap.set("v", "<leader>jsc", "yoconsole.log(\"<Esc>pa: \", <Esc>pa);")

vim.keymap.set("v", "<leader>cdc", "yoprintf(\"%d\\n\", <Esc>pa);<Esc>")
vim.keymap.set("v", "<leader>cfc", "yoprintf(\"%lf\\n\", <Esc>pa);<Esc>")
vim.keymap.set("v", "<leader>csc", "yoprintf(\"%s\\n\", <Esc>pa);<Esc>")
vim.keymap.set("v", "<leader>chc", "yofor (int i = 0; <Esc>pa[i] != '\\0'; i++) {<CR>printf(\"%02X \", <Esc>pa[i]);<CR>}<CR>printf(\"\\n\");<Esc>")
vim.keymap.set("v", "<leader>ccc", "yoprintf('%c\\n', <Esc>pa);<Esc>")

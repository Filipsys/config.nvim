local function jmp(char)
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  if line:sub(col + 1, col + 1) == char then return "<Right>" end
  return char
end

vim.keymap.set("n", "<leader>e", function() vim.cmd("vert Lexplore!") end, { desc = "Open netrw" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>q", function()
  vim.cmd([[silent! %s/\\'/||SINGLEQUOTE||/g]])
  vim.cmd("silent! %s/'/\"/g")
  vim.cmd("silent! %s/||SINGLEQUOTE||/'/g")
end, { desc = "Switch to double quotes", silent = true })

vim.keymap.set("n", "<leader>r", vim.cmd.UndotreeToggle, { desc = "Open undotree" })
if vim.fn.has("persistent_undo") == 1 then
  local target_path = vim.fn.expand("~/.undodir")

  if vim.fn.isdirectory(target_path) == 0 then
    vim.fn.mkdir(target_path, "p", 448)
  end
  vim.o.undodir = target_path
  vim.o.undofile = true
end

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "}", function() return jmp("}") end, { expr = true })
vim.keymap.set("i", "]", function() return jmp("]") end, { expr = true })
vim.keymap.set("i", ")", function() return jmp(")") end, { expr = true })

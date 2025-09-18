vim.keymap.set("n", "<leader>e", function() vim.cmd("vert Lexplore!") end)
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>r", vim.cmd.UndotreeToggle)
if vim.fn.has("persistent_undo") == 1 then
  local target_path = vim.fn.expand("~/.undodir")

  if vim.fn.isdirectory(target_path) == 0 then
    vim.fn.mkdir(target_path, "p", 448)
  end
  vim.o.undodir = target_path
  vim.o.undofile = true
end

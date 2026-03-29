local function jmp(char)
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  if line:sub(col + 1, col + 1) == char then return "<Right>" end
  return char
end

vim.keymap.set("n", "<leader>e", function() vim.cmd("vert Lexplore!") end, { desc = "Open netrw" })
vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float, { desc = "Show diagnostics" })

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

vim.keymap.set("n", "/", function()
  vim.o.hlsearch = true
  return "/"
end, { expr = true, silent = true })
vim.keymap.set("n", "<leader>h", function()
  vim.o.hlsearch = false
end, { desc = "Clear hlsearch" })

vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", { desc = "Copy to clipboard" })
vim.keymap.set({"n", "v"}, "<leader>d", "\"+d", { desc = "Copy & delete to clipboard" })
vim.keymap.set({"n", "v"}, "<leader>p", "\"+p", { desc = "Paste from clipboard" })
vim.keymap.set({"n", "v"}, "<leader>P", "<CR><Esc>\"+p", { desc = "Paste below from clipboard" })

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })

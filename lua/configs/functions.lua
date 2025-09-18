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

local au = vim.api.nvim_create_autocommand

-- Highlight on yank
au("TextYankPost", {
  callback = function() vim.highlight.on_yank { timeout = 300 } end,
})

-- Return to position when opening files
au("BufReadPost", {
  callback = function()
    if vim.fn.line "'\"" > 0 and vim.fn.line "'\"" <= vim.fn.line "$" then
      vim.fn.setpos(".", vim.fn.getpos "'\"")
      vim.cmd "silent! foldopen"
    end
  end,
})

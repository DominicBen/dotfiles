require "nvchad.autocmds"
-- This will cause nvim to close if NvimTree is the only active buffer
vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    vim.defer_fn(function()
      local wins = vim.api.nvim_list_wins()
      if #wins == 1 then
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(wins[1]))
        if bufname:match "NvimTree_" then
          vim.cmd "quit"
        end
      end
    end, 10) -- defer so the window actually closes before we check
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

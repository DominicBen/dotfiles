-- Load additional autocommands from the NvChad configuration
require "nvchad.autocmds"

-- Prevent terminal buffers from being listed in the buffer list
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
    local buflisted = vim.fn.buflisted(bufnr)

    -- Mark disqualified if it's not a normal file buffer
    vim.w.is_disqualified_window = (buftype ~= "" or buflisted == 0)
  end,
})

-- Configure buffer-local options for Copilot-related buffers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    vim.opt_local.relativenumber = false -- Disable relative line numbers
    vim.opt_local.number = false -- Disable absolute line numbers
    vim.opt_local.conceallevel = 0 -- Disable text concealment
  end,
})

-- Attach the Copilot LSP client to CopilotChat buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "copilot-chat",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.name == "copilot" then
        vim.lsp.buf_attach_client(bufnr, client.id) -- Attach the LSP client
        vim.notify("Copilot attached to CopilotChat buffer", vim.log.levels.INFO)
        break
      end
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})

-- Load additional autocommands from the NvChad configuration
require "nvchad.autocmds"

local function is_utility_window(name)
  return name:match "^term://" or name:match "NvimTree_"
end

vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    -- Only try to redirect if we're *currently* in a utility window
    local current_win = vim.api.nvim_get_current_win()

    local bufname = vim.api.nvim_buf_get_name(0)
    -- print("Buffer name: " .. bufname .. " | Current window: " .. current_win)

    if is_utility_window(bufname) then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        if not is_utility_window(name) and vim.api.nvim_buf_get_option(buf, "modifiable") then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end
  end,
})

-- =======================================================================
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

vim.api.nvim_create_user_command("Windows", function()
  print "== Windows in current tabpage =="
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" then
      name = "[No Name]"
    end
    -- print(string.format("Window ID: %d | Buffer ID: %d | File: %s", win, buf, name))
  end
end, {})

vim.deprecate = function(_, _, _, _)
  -- Do nothing, suppress all deprecation warnings
end

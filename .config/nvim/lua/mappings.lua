require "nvchad.mappings"
-- add yours here
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Ctrl Backspace
map("i", "<C-BS>", "<C-w>", { desc = "Delete whole word in insert mode" })
-- Comment
map("n", "<C-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "toggle comment", remap = true }) -- Move line up (Alt+Up)
-- Move line up (Alt+Up)
map("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up", remap = true })
map("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", remap = true })

-- Move line down (Alt+Down)
map("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down", remap = true })
map("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selectea down", remap = true })

map({ "n", "x" }, "<leader>cc", function()
  require("CopilotChat").toggle()
end, { desc = "Toggle Copilot Chat" })
-- Telescope Show diagnostics
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Show Diagnostics" })
-- Visual mode: prompt Copilot about selected code
local chat = require "CopilotChat"
local prompts = chat.prompts()

-- Visual mode keybinds for Copilot commands
local copilot_commands = {
  ce = { cmd = "CopilotChatExplain", desc = "Copilot: Explain code" },
  cf = { cmd = "CopilotChatFix", desc = "Copilot: Fix code" },
  cr = { cmd = "CopilotChatReview", desc = "Copilot: Review code" },
  ct = { cmd = "CopilotChatTests", desc = "Copilot: Test code" },
  cd = { cmd = "CopilotChatDoc", desc = "Copilot: Document code" },
  co = { cmd = "CopilotChatOptimize", desc = "Copilot: Optimize code" },
  cg = { cmd = "CopilotChatCommit", desc = "Copilot: Write Commit" },
}

for key, value in pairs(copilot_commands) do
  map({ "x", "v" }, "<leader>" .. key, function()
    vim.cmd(value.cmd)
  end, { desc = value.desc })
end
-- DAP (Debug Adapter Protocol) keymaps
local opts = { noremap = true, silent = true }

local dap = require "dap"
local dapui = require "dapui"
local dap_python = require "dap-python"

-- Toggle breakpoint
map("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

-- Continue / Start debugging
map("n", "<leader>dc", function()
  dap.continue()
end, { desc = "Continue or start debugging" })

-- Step Over debugging
map("n", "<leader>do", function()
  dap.step_over()
end, { desc = "Step over during debugging" })

-- Step Into debugging
map("n", "<leader>di", function()
  dap.step_into()
end, { desc = "Step into during debugging" })

-- Step Out debugging
map("n", "<leader>dO", function()
  dap.step_out()
end, { desc = "Step out during debugging" })

-- Keymap to terminate debugging
map("n", "<leader>dq", function()
  require("dap").terminate()
end, { desc = "Terminate debugging" })

-- Toggle DAP UI
map("n", "<leader>du", function()
  dapui.toggle()
end, { desc = "Toggle DAP UI" })

map("n", "K", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lnum = cursor[1] - 1

  -- Get diagnostics for current line
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

  if #diagnostics > 0 then
    -- Show diagnostic popup if there's a warning/error on this line
    vim.diagnostic.open_float(nil, {
      border = "rounded",
      focusable = false,
      scope = "line",
    })
  else
    -- Otherwise show hover docs
    vim.lsp.buf.hover()
  end
end, { desc = "Show diagnostics or hover" })

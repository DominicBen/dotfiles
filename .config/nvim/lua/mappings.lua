require "nvchad.mappings"


vim.opt.clipboard = ""

-- add yours here
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Comment
map("n", "<C-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "toggle comment", remap = true })-- Move line up (Alt+Up)
-- Move line up (Alt+Up)
map("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up", remap = true })
map("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", remap = true })

-- Move line down (Alt+Down)
map("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down", remap = true })
map("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selectea down", remap = true })
-- This will cause nvim to close if NvimTree is the only active buffer
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    local wins = vim.api.nvim_list_wins()
    if #wins == 1 then
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname:match("NvimTree_") ~= nil then
        vim.cmd("quit")
      end
    end
  end,
})




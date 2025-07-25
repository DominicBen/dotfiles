local map = vim.keymap.set
if vim.g.vscode then
  local vscode = require "vscode"

  local function changeStatusBar()
    vim.opt.laststatus = 2 -- Always show statusline
    vim.opt.showmode = true -- Hide mode like -- INSERT --
    vim.opt.statusline = "%t %m %r" -- Only show filename and flags
  end
  changeStatusBar()
end

if vim.g.vscode then
  -- VSCode-specific keymap
  map("n", "<leader>e", function()
    vim.fn.VSCodeNotify "workbench.view.explorer"
  end, opts)
else
  -- Regular Neovim keymap (fallback)
  -- map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)
end

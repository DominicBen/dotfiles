if vim.g.vscode then
  local vscode = require "vscode"

  local function changeStatusBar()
    vim.opt.laststatus = 2 -- Always show statusline
    vim.opt.showmode = true -- Hide mode like -- INSERT --
    vim.opt.statusline = "%t %m %r" -- Only show filename and flags
  end
  changeStatusBar()
end

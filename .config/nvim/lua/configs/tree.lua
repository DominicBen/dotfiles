local default = require "nvchad.configs.nvimtree" -- default NvChad config
local custom = {
  hijack_cursor = true,
  view = {
    width = 30,
  },
}

-- Merge your changes into the default config
require("nvim-tree").setup(vim.tbl_deep_extend("force", default, custom))

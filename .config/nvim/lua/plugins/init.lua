return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.lint")
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("configs.conform")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    config = function()
        require("configs.mason-lspconfig")
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
        require("configs.mason-lint")
    end,
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "bash",
        "c",
        "cpp",
        "json",
        "html",
        "css",
        "markdown",
        "yaml",
        "toml",
        "vim",
        "go",
        "rust",
      },
  	},
   {
    "nvim-tree/nvim-tree.lua",
    lazy = false,  -- ensure it's not lazy-loaded
    config = function()
      require("nvim-tree").setup({
        -- your existing setup options
        hijack_cursor = true,
        view = {
          width = 30,
        },
      })
    end,
  },
  }
}

return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    lazy = false,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "kndndrj/nvim-dbee",
    lazy = false, -- ensure it's not lazy-loaded
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup(--[[optional config]])
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      -- require("core.utils").load_mappings "dap"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      -- require("core.utils").load_mappings "dap_python"
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
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
      require "configs.lint"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require "configs.mason-lspconfig"
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
      require "configs.mason-lint"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "spell", group_index = 2 },
        { name = "emoji", group_index = 2 },
        { name = "treesitter", group_index = 2 },
        { name = "calc", group_index = 2 },
        { name = "git", group_index = 2 },
      },
    },
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
      lazy = false, -- ensure it's not lazy-loaded
      config = function()
        require("nvim-tree").setup {
          -- your existing setup options
          hijack_cursor = true,
          view = {
            width = 30,
          },
        }
      end,
    },
  },
}

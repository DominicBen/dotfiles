local map = vim.keymap.set
local M = {
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Find Under"] = "", -- disable Ctrl+n default
      }
    end,
    config = function()
      local keymap = vim.keymap.set

      -- Normal mode mappings
      keymap("n", "<leader>gb", "<Plug>(VM-Find-Under)", { remap = true, desc = "Find Under Cursor" })
      keymap("n", "<leader>ga", "<Plug>(VM-Select-All)", { desc = "Select All Matches" })
      keymap("n", "<leader>gr", "<Plug>(VM-Start-Regex-Search)", { desc = "Start Regex Search" })

      -- Visual mode mappings
      keymap("x", "<leader>gb", "<Plug>(VM-Visual-All)", { desc = "Select All in Visual" })
      keymap("x", "<leader>gn", "<Plug>(VM-Visual-Find)", { desc = "Find Selection" })
      keymap("x", "<leader>gr", "<Plug>(VM-Visual-Regex)", { desc = "Regex Search in Visual" })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "configs.cmp"
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
    "zapling/mason-conform.nvim",
    lazy = false,
    dependencies = { "conform.nvim" },
    config = function()
      require "configs.mason-conform"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    cond = function()
      return not vim.g.vscode
    end,
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
        "htmldjango",
        "css",
        "markdown",
        "yaml",
        "toml",
        "vim",
        "go",
        "rust",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false, -- ensure it's not lazy-loaded
    config = function()
      require "configs.tree"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false, -- ensure it's not lazy-loaded
    ft = {
      "html",
      "htmldjango",
      "xml",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
    },
    config = function()
      require("nvim-ts-autotag").setup {
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "xml",
          "php",
          "markdown",
          "glimmer",
          "handlebars",
          "hbs",
          "htmldjango", -- 👈 Add this
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        get_selection_window = function()
          local cur_win = vim.api.nvim_get_current_win()
          local cur_buf = vim.api.nvim_win_get_buf(cur_win)
          local buftype = vim.api.nvim_buf_get_option(cur_buf, "buftype")

          if buftype == "" then
            return cur_win
          end

          -- Fallback: find another window with a normal buffer
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.api.nvim_buf_get_option(buf, "buftype") == "" then
              return win
            end
          end

          return cur_win
        end,
      },
    },
  },
}

if not vim.g.vscode then
  vim.list_extend(M, {
    {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      config = function()
        require("copilot").setup {
          suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
              accept = "<M-l>",
              accept_word = false,
              accept_line = false,
              next = "<C-n>",
              prev = "<C-p>",
              dismiss = "<C-e>",
            },
          },
          panel = { enabled = false },
        }
      end,
    },
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      lazy = false,
      dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
      opts = {
        question_header = " User ",
        answer_header = "ﮧ Copilot ",
        error_header = " Error ",
        separator = "─",
      },
      config = function(_, opts)
        require("CopilotChat").setup(opts)
        map({ "n", "x" }, "<leader>cc", function()
          vim.cmd "CopilotChatToggle"
        end, { desc = "Toggle Copilot Chat" })
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
          vim.keymap.set({ "x", "v" }, "<leader>" .. key, function()
            vim.cmd(value.cmd)
          end, { desc = value.desc })
        end
      end,
    },
  })
end

return M

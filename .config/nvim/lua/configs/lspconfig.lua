-- Load NvChad defaults
require("nvchad.configs.lspconfig").defaults()
local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

-- Set global LSP defaults for all servers
-- vim.lsp.config("*", {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- })

-- Define per-server config overrides
local serverConfigs = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
  },
  cssls = {
    filetypes = { "css", "scss", "less" },
  },
  html = {
    filetypes = { "html", "htmldjango" },
    init_options = {
      embeddedLanguages = {
        javascript = true,
        css = true,
      },
      provideFormatter = false,
    },
  },
  tsserver = {
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
  pyright = {},
  eslint = {},
}
-- Register each config
for name, config in pairs(serverConfigs) do
  vim.lsp.config(name, config)
  -- print name
  -- print("LSP server configured: " .. name)
end

-- Enable all servers
vim.lsp.enable(vim.tbl_keys(serverConfigs))

-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "lua_ls",
  "cssls",
  "pyright",
  "html",
  "marksman",
  "ts_ls",
  "eslint",
}
lspconfig.servers = servers
-- #ffffff
-- EXAMPLE

-- lsps with default config
for _, lsp in ipairs(servers) do
  if lspconfig[lsp] and not lspconfig[lsp].manager then
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end

lspconfig.html.setup {
  filetypes = { "html", "htmldjango" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    embeddedLanguages = {
      javascript = true,
      css = true,
    },
    provideFormatter = false, -- keep false if you use prettier or external formatter
  },
}

-- test
lspconfig.ts_ls.setup {
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}

lspconfig.cssls.setup {
  filetypes = { "css", "scss", "less" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

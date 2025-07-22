local mason_lspconfig = require "mason-lspconfig"

-- Pull your server list directly from your serverConfigs
local user_server_configs = {
  "lua_ls",
  "cssls",
  "html",
  "ts_ls",
  "pyright",
  "eslint",
}

-- Optional: list of servers to *exclude* from installation
local ignore_install = {}

-- Filter servers: include only those not in ignore_install
local servers_to_install = vim.tbl_filter(function(server)
  return not vim.tbl_contains(ignore_install, server)
end, user_server_configs)

-- Setup Mason LSP
mason_lspconfig.setup {
  ensure_installed = servers_to_install,
  automatic_installation = false, -- or true if you want lazy install
}

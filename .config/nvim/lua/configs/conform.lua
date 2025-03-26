local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
  },

  format_on_save = {

    -- These options will be passed to conform.format()
    lsp_fallback = "fallback",
    timeout_ms = 5000,
  },
}

return options

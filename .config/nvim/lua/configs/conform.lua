local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    cs = { "csharpier" },
  },

  format_on_save = {

    -- These options will be passed to conform.format()
    lsp_fallback = false,
    timeout_ms = 5000,
  },
  formatters = {
    csharpier = {
      command = vim.fn.stdpath "data" .. "/mason/bin/csharpier",
      args = { "format", "$FILENAME" }, -- Add 'format' command!
      stdin = false, -- Must be false: CSharpier works with files
    },
  },
}

return options

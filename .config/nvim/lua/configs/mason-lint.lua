local conform = require "conform"
local mason_conform = require "mason"

-- List of formatters to ignore during install
local ignore_install = {
  -- Example: "prettierd",
}

-- Helper function to check if a table contains a value
local function table_contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

-- Build a list of formatters to install, minus the ignored ones
local all_formatters = {}
for _, formatters in pairs(conform.formatters_by_ft) do
  for _, formatter in ipairs(formatters) do
    if not table_contains(ignore_install, formatter) and not table_contains(all_formatters, formatter) then
      table.insert(all_formatters, formatter)
    end
  end
end

-- Set up mason-conform to ensure installation
mason_conform.setup {
  ensure_installed = all_formatters,
  automatic_installation = false,
}

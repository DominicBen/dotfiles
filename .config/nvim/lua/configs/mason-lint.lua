local lint = require "lint"
local mason_lint = require "mason-nvim-lint" -- or replace with actual `mason-nvim-lint` if you're using it

-- List of linters to ignore during install
local ignore_install = {
  -- Example: "eslint",
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

-- Build a list of linters to install, minus the ignored ones
local all_linters = {}
for _, linters in pairs(lint.linters_by_ft) do
  for _, linter in ipairs(linters) do
    print(linter)
    if not table_contains(ignore_install, linter) and not table_contains(all_linters, linter) then
      table.insert(all_linters, linter)
    end
  end
end

-- Set up mason to ensure installation of linters
mason_lint.setup {
  ensure_installed = all_linters,
  automatic_installation = true,
}

-- mason-conform.lua
local mason_registry = require("mason-registry")
local conform_config = require("configs.conform") -- Adjust path as needed

local formatters_by_ft = conform_config.formatters_by_ft

-- Collect unique formatter names
local all_formatters = {}
for _, formatters in pairs(formatters_by_ft) do
  for _, f in ipairs(formatters) do
    all_formatters[f] = true
  end
end

-- Install all formatters via Mason if not already installed
for formatter, _ in pairs(all_formatters) do
  if mason_registry.has_package(formatter) then
    local pkg = mason_registry.get_package(formatter)
    if not pkg:is_installed() then
      vim.schedule(function()
        vim.notify("Installing missing formatter: " .. formatter, vim.log.levels.INFO)
        pkg:install()
      end)
    end
  else
    vim.schedule(function()
      vim.notify("⚠ Formatter '" .. formatter .. "' not found in Mason registry", vim.log.levels.WARN)
    end)
  end
end


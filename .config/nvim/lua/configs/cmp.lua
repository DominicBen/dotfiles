local cmp = require "cmp"
local defaults = require "nvchad.configs.cmp"

cmp.setup(vim.tbl_deep_extend("force", defaults, {

  sorting = {
    priority_weight = 2,
    comparators = {
      function(entry1, entry2)
        if entry1.source.name == "copilot" then
          return false
        end
        if entry2.source.name == "copilot" then
          return true
        end
        return nil
      end,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  sources = cmp.config.sources(vim.list_extend(defaults.sources, {
    { name = "copilot", group_index = 2 },
  })),
}))

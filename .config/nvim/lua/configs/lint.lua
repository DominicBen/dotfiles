local lint = require "lint"

lint.linters_by_ft = {
  python = { "flake8" },
  lua = { "luacheck" },
  html = { "htmlhint" },
  htmldjango = { "htmlhint" },
}

lint.linters.luacheck.args = {
  unpack(lint.linters.luacheck.args),
  "--globals",
  "love",
  "vim",
}

lint.linters.flake8.args = {
  "--ignore=E501",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})

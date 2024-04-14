local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting

local sources = {
  -- Rust
  require("none-ls.formatting.rustfmt"),

  -- Python
  -- require('none-ls.diagnostics.ruff'),
  require('none-ls.formatting.ruff_format'),

  -- Go
  formatting.gofumpt,

  -- C/C++
  formatting.clang_format,

  require("none-ls-shellcheck.diagnostics"),
  require("none-ls-shellcheck.code_actions"),
}

null_ls.setup {
  debug = true,
  sources = sources,
}

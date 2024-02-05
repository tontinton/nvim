local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  -- Rust
  formatting.rustfmt,

  -- Python
  formatting.autoflake,
  lint.flake8,

  -- Go
  formatting.gofumpt,

  lint.shellcheck,
}

null_ls.setup {
  debug = true,
  sources = sources,
}

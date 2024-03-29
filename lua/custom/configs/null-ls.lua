local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  -- Rust
  formatting.rustfmt,

  -- Python
  formatting.autoflake,
  lint.flake8.with({extra_args = {"--max-line-length", "120"}}),

  -- Go
  formatting.gofumpt,

  -- C/C++
  formatting.clang_format,

  lint.shellcheck,
}

null_ls.setup {
  debug = true,
  sources = sources,
}

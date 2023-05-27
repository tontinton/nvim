local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require("core.utils")
local mason_registry = require("mason-registry")

local lspconfig = require "lspconfig"
local servers = { "jedi_language_server" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Rust config

local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

local options = {
  tools = {
    inlay_hints = {
      auto = true,
      only_current_line = true,
    },
  },
  server = {
    on_attach = function(client, bufnr)
      utils.load_mappings("rust_tools", { buffer = bufnr })
      return on_attach(client, bufnr)
    end,
  },
  capabilities = capabilities,
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    ),
  },
}

require("rust-tools").setup(options)

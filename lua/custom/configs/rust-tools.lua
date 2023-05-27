local utils = require("core.utils")

local mason_registry = require("mason-registry")

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
    on_attach = function(_, buf)
      utils.load_mappings("rust_tools", { buffer = buf })
    end,
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    ),
  },
}

return options

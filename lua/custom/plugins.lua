local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",

        "bash",
        "c",
        "cpp",
        "rust",

        "json",
        "dockerfile",
      },
    },
  },

  {
   "nvim-telescope/telescope.nvim",
   opts = {
     defaults = {
       mappings = {
         i = {
           ["<esc>"] = function(...)
               require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
   },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
          require "custom.configs.null-ls"
      end,
    },
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },

  {
    'TimUntersberger/neogit',
     cmd = "Neogit",
     config = function()
         require("neogit").setup({
           signs = {
             section = { "", "" },
             item = { "", "" },
             hunk = { "", "" },
           },
        })
     end,
  },

  'gabrielpoca/replacer.nvim',

  {
    'tzachar/local-highlight.nvim',
    config = function()
        require('local-highlight').setup()
    end,
  },

  {
    'gbprod/yanky.nvim',
    cmd = "YankyYank",
    config = function()
        require("yanky").setup({
          highlight = {
            on_put = true,
            on_yank = true,
            timer = 100,
          },
        })
    end
  }
}

return plugins

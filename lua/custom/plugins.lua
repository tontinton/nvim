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
        "python",

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
    'RRethy/vim-illuminate',
    init = function()
      vim.defer_fn(function()
        require('illuminate').toggle()
      end, 0)
    end,
    config = function()
      vim.defer_fn(function()
        require('illuminate').configure({
          delay = 0,
        })
        require('illuminate').toggle()
      end, 0)
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
  },

  {
    'phaazon/hop.nvim',
    cmd = { "HopWord", "HopChar1", },
    config = function()
      require("hop").setup({})
    end
  },

  'nvim-telescope/telescope-live-grep-args.nvim',

  -- Debugging

  'mfussenegger/nvim-dap-python',
  'rcarriga/nvim-dap-ui',

  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.fn.sign_define('DapBreakpoint',{ text ='⏺', texthl ='', linehl ='', numhl =''})
      vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

      require('dap-python').setup()
      dap.configurations.python = {
        {
          type = 'python';
          request = 'launch';
          name = "Launch file";
          program = "${file}";
          pythonPath = function()
            return '/usr/bin/python'
          end;
        },
      }
    end
  },

  {
    "folke/neodev.nvim",
    opts = {},
    config = function()
      require('neodev').setup({
        library = {
          plugins = { 'nvim-dap-ui' },
          types = true,
        }
      })
    end
  },
}

return plugins

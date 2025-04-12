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
        "go",
        "javascript",
        "tsx",
        "java",

        "toml",
        "json",
        "dockerfile",
        "hcl",
        "graphql",
        "markdown",
        "markdown_inline",

        "ebnf",
      },
    },
  },

  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  --   init = function()
  --     require("core.utils").lazy_load "nvim-treesitter-context"
  --   end,
  --   config = function()
  --     require("core.utils").load_mappings "treesitter_context"
  --     require('treesitter-context').setup({
  --       max_lines = 2,
  --       trim_scope = 'inner',
  --     })
  --   end,
  -- },

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
      {
        "nvimtools/none-ls.nvim",
        dependencies = {
          "nvimtools/none-ls-extras.nvim",
          "gbprod/none-ls-shellcheck.nvim",
        },
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      -- require('java').setup({
      --   root_markers = {
      --     'settings.gradle',
      --     'settings.gradle.kts',
      --     -- 'pom.xml',
      --     'build.gradle',
      --     'mvnw',
      --     'gradlew',
      --     'build.gradle',
      --     'build.gradle.kts',
      --     '.git',
      --   },
      -- })

      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    cmd = "LazyGit",
    init = function()
      require("core.utils").lazy_load "lazygit.nvim"
    end,
    config = function()
      vim.cmd [[
        autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()
      ]]
    end,
  },

  'gabrielpoca/replacer.nvim',

  {
    'NMAC427/guess-indent.nvim',
    cmd = "GuessIndent",
    init = function()
      require("core.utils").lazy_load "guess-indent.nvim"
    end,
    config = function()
      require('guess-indent').setup({})
    end,
  },

  {
    'mg979/vim-visual-multi',
    init = function()
      require("core.utils").lazy_load "vim-visual-multi"
    end,
  },

  {
    'RRethy/vim-illuminate',
    init = function()
      require("core.utils").lazy_load "vim-illuminate"
    end,
    config = function()
      require('illuminate').configure({
        delay = 0,
      })
    end,
  },

  {
    'gbprod/yanky.nvim',
    cmd = "YankyYank",
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 20,
          storage = "memory",
        },
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

  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    config = function()
      require('render-markdown').setup({})
    end,
  },

  {
    'echasnovski/mini.nvim',
    init = function()
      require("core.utils").lazy_load "mini.nvim"
      require("core.utils").load_mappings "mini"
    end,
    config = function()
      require('mini.ai').setup()
      require('mini.bracketed').setup()
      require('mini.files').setup()
      require('mini.move').setup()
      require('mini.surround').setup()

      local clue = require('mini.clue')
      clue.setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          -- Bracketed
          { mode = 'n', keys = ']' },
          { mode = 'n', keys = '[' },
        },
        clues = {
          -- Debug
          { mode = 'n', keys = '<leader>d', desc="+Debug" },
          { mode = 'n', keys = '<leader>dj', postkeys = '<leader>d' },
          { mode = 'n', keys = '<leader>dl', postkeys = '<leader>d' },
          { mode = 'n', keys = '<leader>dh', postkeys = '<leader>d' },

          -- Bracketed
          { mode = 'n', keys = ']b', postkeys = ']' },
          { mode = 'n', keys = ']w', postkeys = ']' },
          { mode = 'n', keys = '[b', postkeys = '[' },
          { mode = 'n', keys = '[w', postkeys = '[' },

          -- Window
          { mode = 'n', keys = '<C-w>>', postkeys = '<C-w>' },
          { mode = 'n', keys = '<C-w><', postkeys = '<C-w>' },
          { mode = 'n', keys = '<C-w>+', postkeys = '<C-w>' },
          { mode = 'n', keys = '<C-w>-', postkeys = '<C-w>' },

          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
        },
        window = {
          delay = 250, -- ms
          config = {
            width = 'auto',
          }
        }
      })
    end,
  },

  -- Debugging

  'mfussenegger/nvim-dap-python',
  'leoluz/nvim-dap-go',

  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },

  {
    'Weissle/persistent-breakpoints.nvim',
    cmd = { "PBToggleBreakpoint", "PBClearAllBreakpoints" },
    init = function()
      require("core.utils").lazy_load "persistent-breakpoints.nvim"
    end,
    config = function()
      require('persistent-breakpoints').setup({
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
  },

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

      -- Go
      require('dap-go').setup({
        delve = {
          build_flags = "-tags=debug",
        },
      })

      -- Python
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

      -- C/C++
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
      }
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
        },
      }

      -- Rust
      local codelldb_root = require("mason-registry").get_package("codelldb"):get_install_path() .. "/extension/"
      local codelldb_path = codelldb_root .. "adapter/codelldb"
      local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
      dap.adapters.rust = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

      dap.configurations.rust = {
        {
          name = "/target/debug",
          type = "rust",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = true,
          showDisassembly = "never",
        },
      }

      -- Example .vscode/launch.json
      -- {
      --   "version": "0.2.0",
      --   "configurations": [
      --       {
      --           "type": "rust",
      --           "request": "launch",
      --           "name": "Debug Search",
      --           "program": "${fileDirname}/../target/debug/${fileBasenameNoExtension}",
      --           "args": ["search", "~/test/output.index", "1155", "severity_text:INFO", "--limit:", "1"],
      --           "cwd": "${workspaceRoot}",
      --           "sourceLanguages": [
      --               "rust"
      --           ]
      --       },
      --       {
      --           "type": "rust",
      --           "request": "launch",
      --           "name": "Debug Index",
      --           "program": "${fileDirname}/../target/debug/${fileBasenameNoExtension}",
      --           "args": ["index", "~/hdfs-logs-multitenants-10000.json", "~/test"],
      --           "cwd": "${workspaceRoot}",
      --           "sourceLanguages": [
      --               "rust"
      --           ]
      --       }
      --   ]
      -- }
      require('dap.ext.vscode').load_launchjs(nil, {cppdbg = {'c', 'h'}, rt_lldb={'rust'}})
    end
  },

  {
    'simrat39/rust-tools.nvim',
    init = function()
      require("core.utils").lazy_load "rust-tools.nvim"
    end,
  },

  -- {
  --   'nvim-java/nvim-java',
  --   dependencies = {
  --     'nvim-java/nvim-java-refactor',
  --     'nvim-java/lua-async-await',
  --     'nvim-java/nvim-java-core',
  --     'nvim-java/nvim-java-test',
  --     'nvim-java/nvim-java-dap',
  --     'MunifTanjim/nui.nvim',
  --     'neovim/nvim-lspconfig',
  --     'mfussenegger/nvim-dap',
  --     {
  --       'williamboman/mason.nvim',
  --       opts = {
  --         registries = {
  --           'github:nvim-java/mason-registry',
  --           'github:mason-org/mason-registry',
  --         },
  --       },
  --     },
  --   },
  -- },

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

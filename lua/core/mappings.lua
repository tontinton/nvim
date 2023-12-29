-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
    ["<leader>mm"] = { "<cmd> set modifiable <CR>", "Set modifiable" },
    ["<leader>qq"] = { "<cmd> qa <CR>", "Quit neovim" },
    ["<leader>qQ"] = { "<cmd> qa! <CR>", "Quit neovim forced" },
    ["<leader>1"]  = { "<cmd> e <CR>", "Reload buffer" },
    ["<leader>ll"] = { "<cmd> Lazy <CR>", "Lazy" },
    ["<leader>lm"] = { "<cmd> Mason <CR>", "Mason" },
    ["<leader>x"] = { "<cmd> bw <CR>", "Wipe buffer" },
    ["<leader>X"] = { "<cmd> bd <CR>", "Delete buffer" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    ["<leader>fs"] = { "<cmd> w <CR>", "Save file" },
    ["<leader>fS"] = { "<cmd> wa <CR>", "Save all" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { '(v:count > 1 ? "m\'" . v:count : "") . (v:count || mode(1)[0:1] == "no" ? "j" : "gj")', "Move down", opts = { expr = true } },
    ["k"] = { '(v:count > 1 ? "m\'" . v:count : "") . (v:count || mode(1)[0:1] == "no" ? "k" : "gk")', "Move up", opts = { expr = true } },
    ["<Up>"] = { '(v:count > 1 ? "m\'" . v:count : "") . (v:count || mode(1)[0:1] == "no" ? "k" : "gk")', "Move up", opts = { expr = true } },
    ["<Down>"] = { '(v:count > 1 ? "m\'" . v:count : "") . (v:count || mode(1)[0:1] == "no" ? "j" : "gj")', "Move down", opts = { expr = true } },

    -- new buffer
    ["<C-n>"]      = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    -- lazygit
    ["<leader>gg"] = { "<cmd> LazyGitCurrentFile <CR>", "Lazygit file" },
    ["<leader>gG"] = { "<cmd> LazyGit <CR>", "Lazygit dir" },

    -- replacer
    ["<leader>z"] = { "<cmd> lua require('replacer').run() <CR>", "Quickfix replacer" },

    -- hop
    ["<leader>s"] = { "<cmd> HopChar1 <CR>", "Hop to 1 char" },
    ["<leader>S"] = { "<cmd> HopWord <CR>", "Hop to word" },

    -- debug
    ["<leader>b"] = { "<cmd> PBToggleBreakpoint <CR>", "Toggle breakpoint" },

    ["<F9>"] = { "<cmd> lua require('dap').continue() <CR>", "Debug - continue" },
    ["<F8>"] = { "<cmd> lua require('dap').step_over() <CR>", "Debug - step over" },
    ["<F7>"] = { "<cmd> lua require('dap').step_into() <CR>", "Debug - step into" },
    ["<F6>"] = { "<cmd> lua require('dap').step_out() <CR>", "Debug - step out" },

    ["<leader>dc"] = { "<cmd> lua require('dap').continue() <CR>", "Debug - continue" },
    ["<leader>dj"] = { "<cmd> lua require('dap').step_over() <CR>", "Debug - step over" },
    ["<leader>dl"] = { "<cmd> lua require('dap').step_into() <CR>", "Debug - step into" },
    ["<leader>dh"] = { "<cmd> lua require('dap').step_out() <CR>", "Debug - step out" },
    ["<leader>dq"] = { "<cmd> lua require('dap').terminate() <CR>", "Debug - terminate" },

    ["<leader>dR"] = { "<cmd> PBClearAllBreakpoints <CR>", "Debug - clear breakpoints" },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<A-]>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<A-[>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
    ["<C-_>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gr"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    -- ["gd"] = {
    --   function()
    --     vim.lsp.buf.definition()
    --   end,
    --   "LSP definition",
    -- },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>cr"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    -- ["gr"] = {
    --   function()
    --     vim.lsp.buf.references()
    --   end,
    --   "LSP references",
    -- },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" }})
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" }})
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },

    ["<leader>\\"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },

    ["<A-o>"] = {
      "<cmd> ClangdSwitchSourceHeader <CR>",
      "Switch h/c"
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },
}

M.mini = {
  plugin = true,

  n = {
    -- mini.files
    ["<leader>."] = { "<cmd> lua require('mini.files').open(vim.api.nvim_buf_get_name(0)) <CR>", "Open files" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep_args <CR>", "Live grep (args)" },
    ["<leader>fW"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>,"]  = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["gD"]         = { "<cmd> Telescope lsp_references fname_width=80 <CR>", "Find references" },
    ["<leader>fI"] = { "<cmd> Telescope lsp_workspace_symbols fname_width=80 <CR>", "Find project symbols" },
    ["<leader>fi"] = { "<cmd> Telescope lsp_document_symbols fname_width=80 <CR>", "Find buffer symbols" },
    ["gd"]         = { "<cmd> Telescope lsp_definitions fname_width=80 <CR>", "Find definitions" },
    ["<leader>'"]  = { "<cmd> Telescope resume <CR>", "Resume last telescope" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- lazygit
    ["<leader>gp"] = { "<cmd> Telescope lazygit <CR>", "LazyGit projects" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Themes" },

    -- yank history
    ["<leader>y"] = { "<cmd> Telescope yank_history <CR>", "Yank history" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    -- new
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cC"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line({
          full = true
        })
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.rust_tools = {
  plugin = true,

  n = {
    ["<leader>o"] = { "<cmd> lua require('rust-tools').hover_actions.hover_actions() <CR>", "Rust actions" },
    ["<leader>a"] = { "<cmd> lua require('rust-tools').code_action_group.code_action_group() <CR>", "Rust utils" },
  },
}

M.treesitter_context = {
  plugin = true,

  n = {
    ["<leader>cc"] = { "m'<cmd> lua require('treesitter-context').go_to_context() <CR>", "Jump to context" },
  },
}

return M

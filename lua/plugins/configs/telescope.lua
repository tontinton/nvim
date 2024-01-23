local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        prompt_position = "top",
        mirror = true,
        preview_cutoff = 10,
      },
      width = 0.99,
      height = 0.99,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = {
        ["q"] = require("telescope.actions").close,
      },
      i = {
        ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
        ["<C-g>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -g " }),
        ["<C-d>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = ' -g "' .. vim.fn.expand('%:h') .. '/**"' }),
        ["<C-t>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t " }),
      },
    },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    },
  },
  extensions_list = { "themes", "terms", "yank_history", "live_grep_args", "lazygit", "fzf" },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

return options

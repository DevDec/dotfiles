local actions = require('telescope.actions')
local lga_actions = require("telescope-live-grep-args.actions")

require('telescope').setup({
    extensions= {
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({postfix = " --iglob "}),
          },
        },
        previewer = true,
        initial_mode = "normal",
      }
    },
  defaults = {
    path_display = { truncate = 1 },
    prompt_prefix = '   ',
    selection_caret = '  ',
    sorting_strategy = 'ascending',
    file_ignore_patterns = { '.git/' },
  },
  pickers = {
    find_files = {
      hidden = true,
      initial_mode = "normal"
    },
    buffers = {
      previewer = false,
      initial_mode = "normal",
      layout_config = {
        width = 80,
      },
    },
    live_grep = {
      previewer = true,
      initial_mode = "normal",
    },
    oldfiles = {
      initial_mode = "normal",
      prompt_title = 'History',
    },
    lsp_references = {
      initial_mode = "normal",
      previewer = true,
    },
    lsp_implementations = {
      initial_mode = "normal",
      previewer = true,
    },
    lsp_document_symbols = {
      initial_mode = "normal",
      previewer = true,
    }
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('harpoon')

vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({noremap=true})<CR>]])
vim.keymap.set('n', '<leader>o', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])

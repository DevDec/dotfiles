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
      },
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    },
    defaults = {
      prompt_prefix = ">  ",
      previewer = false,
      initial_mode = "normal",
      path_display = { truncate = 1 },
      sorting_strategy = 'ascending',
      file_ignore_patterns = { '.git/' },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      buffers = {
        layout_config = {
          width = 80,
        },
      },
      oldfiles = {
        prompt_title = 'History',
      },
      commands = {
        initial_mode = "normal"
      }
    },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('harpoon')
require('telescope').load_extension('git_worktree')
require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({noremap=true})<CR>]])
vim.keymap.set('n', '<leader>o', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
vim.keymap.set('n', '<leader>m', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
vim.keymap.set('n', '<leader>r' , [[<cmd>lua require('telescope.builtin').registers()<CR>]])
vim.keymap.set('n', '<leader>c' , [[<cmd>lua require('telescope.builtin').commands()<CR>]])
vim.keymap.set("n", "<Tab>h", function()
     return ":lua require('harpoon.ui').nav_file(" .. vim.v.count .. ")<CR>" end, {expr = true})


vim.keymap.set('n', '<leader>wo', [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>]])
vim.keymap.set('n', '<leader>wc', [[<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>]])

   

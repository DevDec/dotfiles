local lga_actions = require("telescope-live-grep-args.actions")
local telescope_custom_extensions = require('user/plugins/navigation/config/telescope/telescope-custom-extensions')

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
      -- fzf = {
      --   fuzzy = true,                    -- false will only do exact matching
      --   override_generic_sorter = true,  -- override the generic sorter
      --   override_file_sorter = true,     -- override the file sorter
      --   case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      --   -- the default case_mode is "smart_case"
      -- }
    },
	path_display = { "truncate" },
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
        -- layout_config = {
        --   width = 80,
        -- },
      },
      oldfiles = {
        prompt_title = 'History',
      },
      commands = {
        initial_mode = "normal"
      },
      live_grep_args = {


      },
      git_stash = {
        mappings = {
          n = {
            ["<c-d>"] = telescope_custom_extensions.git.drop_stash,
          },
        },
      }
    },
})

-- require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('harpoon')
require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("git_file_history")
-- require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', function() telescope_custom_extensions.middleware(builtin.find_files, 'Find Files') end)
vim.keymap.set('n', '<leader>F', function() telescope_custom_extensions.middleware(builtin.find_files, 'All Files', { no_ignore = true, prompt_title = 'All Files' }) end)
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>G', function() telescope_custom_extensions.middleware(require('telescope').extensions.live_grep_args.live_grep_args, 'Live Grep (Args)', {noremap=true}) end)
vim.keymap.set('n', '<leader>m', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>s', function()
  local clients = vim.lsp.buf_get_clients()
  for key, value in pairs(clients) do
    if value.name == 'lua_ls' then
      vim.lsp.buf.document_symbol()
      return
    end
  end
  vim.cmd('Telescope lsp_document_symbols')
end)

local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set("n", "<leader>gc", live_grep_args_shortcuts.grep_word_under_cursor)

vim.keymap.set('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]])
vim.keymap.set('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]])
vim.keymap.set('n', '<leader>r' , [[<cmd>lua require('telescope.builtin').registers()<CR>]])
vim.keymap.set('n', '<leader>c' , [[<cmd>lua require('telescope.builtin').commands()<CR>]])

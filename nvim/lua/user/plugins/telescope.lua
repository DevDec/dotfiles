local lga_actions = require("telescope-live-grep-args.actions")
local telescope_custom_extensions = require('telescope-custom-extensions')

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

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('harpoon')
require('telescope').load_extension('git_worktree')
require('telescope').load_extension('fzf')
local telescope_state = require('telescope.state')
local telescope = require('telescope.builtin')

local function telescope_middleware(func, title, args)
  local cached_pickers = telescope_state.get_global_key "cached_pickers" or {}
  local files_picker = nil

  for _, value in pairs(cached_pickers) do
    if value.prompt_title == title then
      files_picker = value
      break
    end
  end

  if files_picker then
     telescope.resume({ picker = files_picker })
     return
   else
     func(args)
   end
 end

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', function() telescope_middleware(builtin.find_files, 'Find Files') end)
vim.keymap.set('n', '<leader>F', function() telescope_middleware(builtin.find_files, 'All Files', { no_ignore = true, prompt_title = 'All Files' }) end)
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>g', function() telescope_middleware(require('telescope').extensions.live_grep_args.live_grep_args, 'Live Grep (Args)', {noremap=true}) end)
vim.keymap.set('n', '<leader>o', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
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
-- vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
-- vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]])
vim.keymap.set('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]])
vim.keymap.set('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]])
vim.keymap.set('n', '<leader>m', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
vim.keymap.set('n', '<leader>r' , [[<cmd>lua require('telescope.builtin').registers()<CR>]])
vim.keymap.set('n', '<leader>c' , [[<cmd>lua require('telescope.builtin').commands()<CR>]])

vim.keymap.set('n', '<leader>wo', [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>]])
vim.keymap.set('n', '<leader>wc', [[<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>]])

   

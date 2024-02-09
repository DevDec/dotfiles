local actions = require('telescope.actions')
local lga_actions = require("telescope-live-grep-args.actions")
local action_state = require "telescope.actions.state";
local utils = require "telescope.utils"

--- Ask user to confirm an action
---@param prompt string: The prompt for confirmation
---@param default_value string: The default value of user input
---@param yes_values table: List of positive user confirmations ({"y", "yes"} by default)
---@return boolean: Whether user confirmed the prompt
local function ask_to_confirm(prompt, default_value, yes_values)
  yes_values = yes_values or { "y", "yes" }
  default_value = default_value or ""
  local confirmation = vim.fn.input(prompt, default_value)
  confirmation = string.lower(confirmation)
  if string.len(confirmation) == 0 then
    return false
  end
  for _, v in pairs(yes_values) do
    if v == confirmation then
      return true
    end
  end
  return false
end

local git_drop_stash = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()

  local confirmation = ask_to_confirm(string.format("Drop stash '%s'? [y/n]: ", selection.value))
  if not confirmation then
    utils.notify("actions.git_drop_stash", {
        msg = string.format("Drop stash canceled: '%s'", selection.value),
        level = "INFO",
      })
    return
  end

  local picker = action_state.get_current_picker(prompt_bufnr)
  picker:delete_selection(function(selection)
    local _, ret, stderr = utils.get_os_command_output { "git", "stash", "drop", selection.value }

    if ret == 0 then
      utils.notify("actions.git_drop_stash", {
          msg = string.format("Dropped stash: '%s' ", selection.value),
          level = "INFO",
        })
    else
      utils.notify("actions.git_apply_stash", {
          msg = string.format("Error when dropping: %s. Git returned: '%s'", selection.value, table.concat(stderr, " ")),
          level = "ERROR",
        })
    end    

    return ret == 0
  end)
end

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
            ["<c-d>"] = git_drop_stash,
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

vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({noremap=true})<CR>]])
vim.keymap.set('n', '<leader>o', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
vim.keymap.set('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]])
vim.keymap.set('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]])
vim.keymap.set('n', '<leader>m', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
vim.keymap.set('n', '<leader>r' , [[<cmd>lua require('telescope.builtin').registers()<CR>]])
vim.keymap.set('n', '<leader>c' , [[<cmd>lua require('telescope.builtin').commands()<CR>]])
vim.keymap.set("n", "<Tab>h", function()
     return ":lua require('harpoon.ui').nav_file(" .. vim.v.count .. ")<CR>" end, {expr = true})


vim.keymap.set('n', '<leader>wo', [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>]])
vim.keymap.set('n', '<leader>wc', [[<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>]])

   

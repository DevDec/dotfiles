require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  sync_root_with_cwd = true,
})

-- local function toggle_replace()
--
--   if api.tree.is_visible() then
-- 	vim.print("Closing tree")
--     api.tree.close()
--   else
-- 	  vim.print("Opening tree")
--     api.node.open.replace_tree_buffer()
--   end
-- end

local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>no", function() api.tree.open({ current_window = true }) end, { noremap = true })
-- vim.keymap.set('n', '<Leader>nf', ':NvimTreeFocus<CR>')

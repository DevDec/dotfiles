local harpoon = require("harpoon")
harpoon.setup(harpoon, {})
vim.keymap.set('n', '<Leader>ho', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<Leader>ha', function() harpoon:list():append() end)


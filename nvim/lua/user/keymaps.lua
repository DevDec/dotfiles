-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Quickly clear search highlighting.
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>')

-- Close all open buffers.
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>')

-- Allow gf to open non-existent files.
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Paste replace visual selection without copying it.
-- vim.keymap.set('v', 'p', '"_dP')

-- Key mappings to delete to the black hole register
vim.keymap.set('v', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })

-- Key mappings to delete with yanking (Standard behavior)
vim.keymap.set('v', '<leader>d', 'd', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', 'd', { noremap = true, silent = true })

-- Key mappings to paste from the system clipboard
vim.keymap.set('v', '<leader>p', '"+p', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true })

-- Key mappings to yank to the system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true, silent = true })

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<leader>x', ':!open %<cr><cr>')

-- Disable annoying command line thing.
vim.keymap.set('n', 'q:', ':q<CR>')

-- Resize with arrows.
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")

-- Quickfix list navigation
vim.keymap.set('n', '<leader>co', ':copen<CR>')
vim.keymap.set('n', '<leader>cd', ':cclose<CR>')
vim.keymap.set('n', '<leader>cn', ':cnext<CR>')
vim.keymap.set('n', '<leader>cp', ':cprev<CR>')


-- Repeat the `.` command multiple times
function MyRepeatDot()
	return vim.api.nvim_replace_termcodes('<esc>' .. string.rep('.', vim.v.count1), true, true, true)
end

vim.api.nvim_set_keymap('n', '<leader>.', 'v:lua.MyRepeatDot()', { expr = true, noremap = true, silent = true })


-- Define the function to repeat the `.` command to the end of the file
function RepeatDotToEnd()
	-- Save the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	-- Increment the line number by one to get the next line
	local current_search_number = cursor_pos[1] + 1
	-- local lines = vim.api.nvim_buf_line_count(0)
	local lines = vim.fn.searchcount({ maxcount = 0 })

	-- Execute the `.` command repeatedly until the end of the file
	for _ = current_search_number, lines.total + 1 do
		vim.cmd('normal .')
	end
end

-- Set the keymap
vim.api.nvim_set_keymap('n', '<leader>r.', ':lua RepeatDotToEnd()<CR>', { noremap = true, silent = true })

return {
	{
		'echasnovski/mini.diff',
		version = 'stable',
		config = function()
			require('mini.diff').setup({ view = { style = 'sign' } })
			vim.keymap.set('n', 'gp', ':lua MiniDiff.toggle_overlay()<CR>')
		end
	},
	{
		'tpope/vim-fugitive',
		dependencies = 'tpope/vim-rhubarb',
	},
}

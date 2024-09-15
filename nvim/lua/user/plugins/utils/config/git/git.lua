return {
	-- Git integration.
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('user/plugins/utils/config/git/gitsigns')
		end,
	},
	-- Git commands.
	{
		'tpope/vim-fugitive',
		dependencies = 'tpope/vim-rhubarb',
	},
	{ 'sindrets/diffview.nvim' },
}

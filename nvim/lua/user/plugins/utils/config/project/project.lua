return {
	-- Project Configuration.
	{
		'tpope/vim-projectionist',
		dependencies = 'tpope/vim-dispatch',
		config = function()
			require('user/plugins/utils/config/project/projectionist')
		end,
	},
	-- Automatically set the working directory to the project root.
	{
		'airblade/vim-rooter',
		init = function()
			vim.g.rooter_manual_only = 1
		end,
		config = function()
			vim.cmd('Rooter')
		end,
	},
}

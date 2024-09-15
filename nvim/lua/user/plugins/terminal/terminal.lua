return {
	-- amongst your other plugins
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require('user/plugins/terminal/config/toggleterm')
		end
	},
}

return {
	{
		'echasnovski/mini.indentscope',
		version = '*',
		config = function()
			require('mini.indentscope').setup()
		end
	},
	{
		'echasnovski/mini.cursorword',
		version = '*',
		config = function()
			require('mini.cursorword').setup()
		end
	},
	{
		'echasnovski/mini.surround',
		version = '*',
		config = function()
			require('mini.surround').setup()
		end,
	},
	{
		'echasnovski/mini.ai',
		version = '*',
		config = function()
			require('mini.ai').setup()
		end
	},
	{
		'echasnovski/mini.splitjoin',
		version = '*',
		config = function()
			require('user/plugins/utils/config/mini/splitjoin')
		end
	},
	{
		'echasnovski/mini.comment',
		version = '*',
		config = function()
			require('mini.comment').setup()
		end
	},
	-- {
	-- 	'echasnovski/mini.pairs',
	-- 	version = '*',
	-- 	config = function()
	-- 		require('mini.pairs').setup()
	-- 	end
	-- },
	{
		'echasnovski/mini.move',
		version = '*',
		config = function()
			require('mini.move').setup()
		end
	},
	{
		'echasnovski/mini.operators',
		version = '*',
		config = function()
			require('user/plugins/utils/config/mini/operators')
		end
	},
}

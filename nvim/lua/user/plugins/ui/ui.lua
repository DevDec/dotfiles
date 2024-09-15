return {
	-- A Status line.
	{
		'nvim-lualine/lualine.nvim',
		dependencies = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('user/plugins/ui/config/lualine')
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require('fidget').setup()
		end
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require('neoscroll').setup {}
		end
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		}
	}
}

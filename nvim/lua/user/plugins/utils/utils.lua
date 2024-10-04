return {
	{
		"nvim-lua/plenary.nvim",
		config = function()
			local plenary = require("plenary")
			local function reload_module(...)
				plenary.reload.reload_module(...)
			end

			vim.api.RELOAD = reload_module
		end,
	},
	{import = "user/plugins/utils/config/mini/mini"},
	{import = "user/plugins/utils/config/completion/completion"},
	{import = "user/plugins/utils/config/git/git"},
	{import = "user/plugins/utils/config/conform/conform"},
	{import = "user/plugins/utils/config/retirement/retirement"},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'onsails/lspkind-nvim',
			'kristijanhusak/vim-dadbod-completion'
		},
		config = function()
			require('user/plugins/utils/config/completion/cmp')
		end,
	},
	{
		name = "transmit",
		'DevDec/transmit.nvim',
		dir = "~/projects/transmit.nvim.git/main/",
		dependencies = {
			{ 'rktjmp/fwatch.nvim' }
		},
		config = function()
			require('user/plugins/utils/config/transmit')

			local function loadTransmit()
				vim.cmd("lua package.loaded['transmit'] = nil")
				vim.cmd("lua package.loaded['transmit.util'] = nil")
				vim.cmd("lua package.loaded['transmit.watcher'] = nil")
				vim.cmd("lua package.loaded['transmit.sftp'] = nil")
				vim.cmd("lua package.loaded['transmit.sftp-queue'] = nil")
				vim.cmd("lua package.loaded['transmit.ui'] = nil")

				vim.cmd("lua require('user/plugins/utils/config/transmit')")

				local transmit = require('transmit')

				transmit.setup({
					config_location = "/home/declanb/transmit_sftp/config.json",
					upload_on_bufwrite = false,
					watch_for_changes = true
				})
			end

			vim.api.nvim_create_user_command('TransmitReload', function()
				loadTransmit()
			end,{})
		end
	},
	-- Pairs of handy bracket mappings, like [b and ]b.
	{ 'tpope/vim-unimpaired' },
	{
		'jinh0/eyeliner.nvim',
		config = function()
			require('eyeliner').setup({
				highlight_on_key = true, -- this must be set to true for dimming to work!
				dim = true,
			})
		end
	},
	-- Allow plugins to enable repeating of commands.
	{ 'tpope/vim-repeat' },
	-- Jump to the last location when opening a file.
	{ 'farmergreg/vim-lastplace' },
	-- Text objects for HTML attributes.
	{
		'whatyouhide/vim-textobj-xmlattr',
		dependencies = 'kana/vim-textobj-user',
	},
	{
		"ohakutsu/socks-copypath.nvim",
		config = function()
			require("socks-copypath").setup()
		end,
	},
	{ 'ThePrimeagen/vim-be-good' },
	{ "stefandtw/quickfix-reflector.vim" },
	{ 'wakatime/vim-wakatime', lazy = false },
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "DecsVault",
					path = "/home/declanb/Documents/Projects/DecsVault/",
				},
			},
		},
	},
	{
		"chrisgrieser/nvim-recorder",
		-- dependencies = "rcarriga/nvim-notify", -- optional
		opts = {}, -- required even with default settings, since it calls `setup()`
	},
}

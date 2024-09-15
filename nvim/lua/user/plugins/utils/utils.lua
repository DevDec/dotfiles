return {
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
		dir = "~/projects/transmit.nvim.git/main",
		dependencies = {
			{ 'rktjmp/fwatch.nvim' }
		},
		config = function()
			require('user/plugins/utils/config/transmit')
		end
	},
	-- Pairs of handy bracket mappings, like [b and ]b.
	{ 'tpope/vim-unimpaired' },
	{ 'easymotion/vim-easymotion' },

	-- Useful commands like :Rename and :SudoWrite.
	{ 'tpope/vim-eunuch' },
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
	-- Enable * searching with visually selected text.
	{ 'nelstrom/vim-visual-star-search' },
	-- Text objects for HTML attributes.
	{
		'whatyouhide/vim-textobj-xmlattr',
		dependencies = 'kana/vim-textobj-user',
	},
	-- Automatically fix indentation when pasting code.
	{
		'sickill/vim-pasta',
		config = function()
			vim.g.pasta_disabled_filetypes = { 'fugitive' }
		end,
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
}

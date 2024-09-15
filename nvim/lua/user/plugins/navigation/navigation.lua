return {
	-- Fork of the original Primeagen plugin (Fixes bug)
	{
		'DevDec/git-worktree.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require('user/plugins/navigation/config/worktree')
		end,
	},
	-- Fuzzy finder
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons',
			'nvim-telescope/telescope-live-grep-args.nvim',
		},
		config = function()
			require('user/plugins/navigation/config/telescope/telescope')
		end,
	},
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			require("user/plugins/navigation/config/nvim-tree")
		end
	},
	{
		'linrongbin16/lsp-progress.nvim',
		config = function()
			require('user/plugins/navigation/config/lsp/lsp-progress')
		end,
	},
	-- Improved syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			require('nvim-treesitter.install').update({ with_sync = true })
		end,
		dependencies = {
			'JoosepAlviste/nvim-ts-context-commentstring',
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			require('user/plugins/navigation/config/lsp/treesitter')
		end,
	},
	{ 'VonHeikemen/lsp-zero.nvim',                branch = 'v3.x' },
	-- Language Server Protocol.
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'b0o/schemastore.nvim',
			'jose-elias-alvarez/null-ls.nvim',
			'jayp0521/mason-null-ls.nvim',
		},
		config = function()
			require('user/plugins/navigation/config/lsp/lspconfig')
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("user/plugins/navigation/config/harpoon")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require'treesitter-context'.setup{
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			}
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
		end
	},
}

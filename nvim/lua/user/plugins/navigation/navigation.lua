return {
	-- Fuzzy finder
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{'nvim-telescope/telescope-ui-select.nvim' },
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
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
				},
			},
			never_show = {},
		},
		config = function()
			require('neo-tree').setup({
				filesystem = {
					filtered_items = {
						visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					},
				},
				never_show = {},
			});

			vim.keymap.set('n', '<leader>no', ':Neotree toggle reveal=true position=current<CR>')
		end
	},
	-- {
	-- 	'nvim-tree/nvim-tree.lua',
	-- 	config = function()
	-- 		require("user/plugins/navigation/config/nvim-tree")
	-- 	end
	-- },
	{
		'linrongbin16/lsp-progress.nvim',
		config = function()
			require('user/plugins/navigation/config/lsp/lsp-progress')
		end,
	},
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
				multiline_threshold = 1, -- Maximum number of lines to show for a single context
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
	{
		"gbprod/phpactor.nvim",
		-- build = function()
		-- 	require("phpactor.handler.update")()
		-- end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig"
		},
		opts = {
			bin = "/usr/bin/phpactor",
			-- you're options coes here
		},
	},
}

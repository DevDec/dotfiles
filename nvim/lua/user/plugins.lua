require("lazy").setup({
    {
      'maxmx03/dracula.nvim',
      config = function()
        local dracula = require 'dracula'
        local draculapro = require 'draculapro'

        draculapro.setup({
            theme = 'morbius'
          })

        dracula.setup {
          dracula_pro = draculapro,
          colors = draculapro.colors
        }

        vim.cmd.colorscheme 'dracula'
      end,
      dependencies = {
        'DevDec/dracula-pro',
      },
    },
    {'DevDec/git-worktree.nvim'},
    {'easymotion/vim-easymotion'},
    {
      name = "transmit",
      'DevDec/transmit.nim',
      dir = "/Volumes/T7/transmit.nvim.git/main"
    },
    {'sindrets/diffview.nvim'},
    -- Commenting support.
    {'tpope/vim-commentary'},

    -- Add, change, and delete surrounding text.
    {'tpope/vim-surround'},

    -- Useful commands like :Rename and :SudoWrite.
    {'tpope/vim-eunuch'},

    -- Pairs of handy bracket mappings, like [b and ]b.
    {'tpope/vim-unimpaired'},

    -- Indent autodetection with editorconfig support.
    {'tpope/vim-sleuth'},

    -- Allow plugins to enable repeating of commands.
    {'tpope/vim-repeat'},

    -- Add more languages.
    {'sheerun/vim-polyglot'},

    -- Navigate seamlessly between Vim windows and Tmux panes.
    {'christoomey/vim-tmux-navigator'},

    -- Jump to the last location when opening a file.
    {'farmergreg/vim-lastplace'},

    -- Enable * searching with visually selected text.
    {'nelstrom/vim-visual-star-search'},

    -- Automatically create parent dirs when saving.
    {'jessarcher/vim-heritage'},

    -- Text objects for HTML attributes.
    {
      'whatyouhide/vim-textobj-xmlattr',
      dependencies = 'kana/vim-textobj-user',
    },

    -- Automatically set the working directory to the project root.
    {
      'airblade/vim-rooter',
      init = function()
        -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
        vim.g.rooter_manual_only = 1
      end,
      config = function()
        vim.cmd('Rooter')
      end,
    },

    -- Automatically add closing brackets, quotes, etc.
    {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
      end,
    },

    -- -- Add smooth scrolling to avoid jarring jumps
    -- {
    --   'karb94/neoscroll.nvim',
    --   config = function()
    --     require('neoscroll').setup()
    --   end,
    -- },

    -- Split arrays and methods onto multiple lines, or join them back up.
    {
      'AndrewRadev/splitjoin.vim',
      config = function()
        vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
        vim.g.splitjoin_trailing_comma = 1
        vim.g.splitjoin_php_method_chain_full = 1
      end,
    },

    -- Automatically fix indentation when pasting code.
    {
      'sickill/vim-pasta',
      config = function()
        vim.g.pasta_disabled_filetypes = { 'fugitive' }
      end,
    },

    -- Fuzzy finder
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
      config = function()
        require('user/plugins/telescope')
      end,
    },

    -- File tree sidebar
    {
      'kyazdani42/nvim-tree.lua',
      dependencies = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('user/plugins/nvim-tree')
      end,
    },

    -- A Status line.
    {
      'nvim-lualine/lualine.nvim',
      dependencies = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('user/plugins/lualine')
      end,
    },

    -- Add a dashboard.
    {
      'glepnir/dashboard-nvim',
      config = function()
        require('user/plugins/dashboard-nvim')
      end
    },

    -- Git integration.
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup({current_line_blame = true})
        vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
        vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
        vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
        vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
        vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
      end,
    },

    -- Git commands.
    {
      'tpope/vim-fugitive',
      dependencies = 'tpope/vim-rhubarb',
    },

    --- Floating terminal.
    {
      'voldikss/vim-floaterm',
      config = function()
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
        vim.keymap.set('n', '<Tab>t', ':FloatermToggle<CR>')
        vim.keymap.set('t', '<Tab>t', '<C-\\><C-n>:FloatermToggle<CR>')
        vim.cmd([[
          highlight link Floaterm CursorLine
      highlight link FloatermBorder CursorLineBg
    ]])
      end
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
        require('user/plugins/treesitter')
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
        require('user/plugins/lspconfig')
      end,
    },

    -- Completion
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
      },
      config = function()
        require('user/plugins/cmp')
      end,
    },

    -- PHP Refactoring Tools
    {
      'phpactor/phpactor',
      ft = 'php',
      build = 'composer install --no-dev --optimize-autoloader',
      config = function()
        vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
        vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
      end,
    },

    -- Project Configuration.
    {
      'tpope/vim-projectionist',
      dependencies = 'tpope/vim-dispatch',
      config = function()
        require('user/plugins/projectionist')
      end,
    },

    -- Testing helper
    {
      'vim-test/vim-test',
      config = function()
        require('user/plugins/vim-test')
      end,
    },

    {
      'ThePrimeagen/harpoon',
      config = function()
        require('harpoon').setup({
            tabline = true
          })
        vim.keymap.set('n', '<Leader>ho', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
        vim.keymap.set('n', '<Leader>ha', ':lua require("harpoon.mark").add_file()<CR>')
      end,
    },

    {
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        vim.keymap.set('n', '<Leader>l', ':LazyGit<CR>')
      end,
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    }
  })

require("lazy").setup({
    {
      "folke/neodev.nvim",
      opts = {},
    },
    -- {
    --   'maxmx03/dracula.nvim',
    --   config = function()
    --   require('user/plugins/themes/dracula')
    --   end,
    --   dependencies = {
    --     'DevDec/dracula-pro',
    --   },
    -- },
    {
      "catppuccin/nvim", name = "catppuccin",
      priority = 1000,
      config = function()
        require('user/plugins/themes/catppuccin')
      end
    },
    -- Fork of the original Primeagen plugin (Fixes bug)
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
    -- {'sheerun/vim-polyglot'},

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
    -- Split arrays and methods onto multiple lines, or join them back up.
    {
      'AndrewRadev/splitjoin.vim',
      config = function()
        require('user/plugins/utils/splitjoin')
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
        require('user/plugins/navigation/telescope/telescope')
      end,
    },
    {
      'ms-jpq/chadtree',
      branch = 'chad',
      build = 'python3 -m chadtree deps',
      config = function()
        require('user/plugins/navigation/chadtree')
      end,
    },
    -- File tree sidebar
    -- {
    --   'kyazdani42/nvim-tree.lua',
    --   dependencies = 'kyazdani42/nvim-web-devicons',
    --   config = function()
    --     require('user/plugins/navigation/nvim-tree')
    --   end,
    -- },

    -- A Status line.
    {
      'nvim-lualine/lualine.nvim',
      dependencies = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('user/plugins/ui/lualine')
      end,
    },
    -- Git integration.
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('user/plugins/utils/gitsigns')
      end,
    },
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require('user/plugins/navigation/lsp/lsp-progress')
      end
    },
    -- Git commands.
    {
      'tpope/vim-fugitive',
      dependencies = 'tpope/vim-rhubarb',
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
        require('user/plugins/navigation/lsp/treesitter')
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
        require('user/plugins/navigation/lsp/lspconfig')
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
        require('user/plugins/utils/cmp')
      end,
    },
    {
      'phpactor/phpactor',
      version = '2022.11.12',
      ft = 'php',
      build = 'composer install --no-dev --optimize-autoloader',
      config = function()
        require('user/plugins/navigation/lsp/phpactor')
      end,
    },
    -- Project Configuration.
    {
      'tpope/vim-projectionist',
      dependencies = 'tpope/vim-dispatch',
      config = function()
        require('user/plugins/utils/projectionist')
      end,
    },
    -- Testing helper
    {
      'vim-test/vim-test',
      config = function()
        require('user/plugins/utils/vim-test')
      end,
    },
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("user/plugins/navigation/harpoon")
      end,
    },
    -- LazyGit integration.
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
    -- fzf native for telescope
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build', },
    -- AI Assisted writing.
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("user/plugins/utils/copilot")
      end,
    },
    -- Note taking.
    {
      "epwalsh/obsidian.nvim",
      version = "*",  -- recommended, use latest release instead of latest commit
      lazy = true,
      ft = "markdown",
      -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
      -- event = {
      --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      --   "BufReadPre path/to/my-vault/**.md",
      --   "BufNewFile path/to/my-vault/**.md",
      -- },
      dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
      },
      opts = {
        workspaces = {
          {
            name = "personal",
            path = "~/Documents/AImSmarterVault",
          },
        },
      },
    },
    -- Practice Vim commands.
    {'ThePrimeagen/vim-be-good'}
  })

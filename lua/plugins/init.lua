local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
    -- Package manager
    { 'wbthomason/packer.nvim' },
    -- LSP
    { 'williamboman/mason.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'jay-babu/mason-nvim-dap.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    {
        'nvimtools/none-ls.nvim',
        dependencies = "gbprod/none-ls-shellcheck.nvim",
    },
    { 'mfussenegger/nvim-jdtls' },
    -- CMP
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    {
        'Exafunction/codeium.vim',
        config = function()
            require 'plugins.config.codeium'
        end
    },
    {
        'xeluxee/competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        config = function()
            require 'plugins.config.competitest'
        end
    },
    -- Debugger
    { 'mfussenegger/nvim-dap' },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        }
    },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'folke/neodev.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'mfussenegger/nvim-dap-python' },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        tag = "v2.*",
        run = "make install_jsregexp"
    },
    { "rafamadriz/friendly-snippets" },
    { "saadparwaiz1/cmp_luasnip" },
    -- Extended functionality
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'BurntSushi/ripgrep',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require 'plugins.config.telescope'
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', -- Improves sorting performance
        run = 'make',
    },
    {
        'jvgrootveld/telescope-zoxide',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'nvim-telescope/telescope-ui-select.nvim', -- Presents native selection dialogs with telescope
        config = function()
            require 'plugins.config.telescope-ui-select'
        end
    },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    {
        'folke/zen-mode.nvim',
        config = function()
            require 'plugins.config.zen-mode'
        end
    },
    {
        'ZSaberLv0/eregex.vim',
        config = function()
            require 'plugins.config.eregex'
        end
    },
    { 'stevearc/dressing.nvim' },
    { 'mbbill/undotree' },
    { 'preservim/tagbar' },
    { 'fidian/hexmode' },
    { 'mattn/emmet-vim' },
    -- Enhancements
    {
        'Shatur/neovim-session-manager',
        config = function()
            require 'plugins.config.session-manager'
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require 'plugins.config.comment'
        end
    },
    { 'Raimondi/delimitMate' },
    {
        'phaazon/hop.nvim',
        config = function()
            require 'plugins.config.hop'
        end
    },
    { 'svermeulen/vim-cutlass' },
    {
        'airblade/vim-rooter',
        config = function()
            require 'plugins.config.rooter'
        end
    },
    {
        'nacro90/numb.nvim',
        config = function()
            require 'plugins.config.numb'
        end
    },
    {
        'VonHeikemen/searchbox.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim'
        }
    },
    { 'rickhowe/diffchar.vim' },    -- Better diff mode
    { 'tpope/vim-surround' },
    { 'lewis6991/impatient.nvim' }, -- Improves overall performance
    -- Interface
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'plugins.config.alpha'
        end
    },
    {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require 'plugins.config.nvim-tree'
        end
    },
    {
        'akinsho/bufferline.nvim',
        config = function()
            require 'plugins.config.bufferline'
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require 'plugins.config.lualine'
        end
    },
    {
        'sudormrfbin/cheatsheet.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require 'plugins.config.cheatsheet'
        end
    },
    -- Aesthetic
    { 'sainnhe/gruvbox-material' },
    -- { 'rebelot/kanagawa.nvim' },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require 'plugins.config.treesitter'
        end
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'plugins.config.colorizer'
        end
    },
    { 'mtdl9/vim-log-highlighting' },
    { 'ryanoasis/vim-devicons' },
    -- lazy configuration
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})

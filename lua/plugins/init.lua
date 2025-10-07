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

require("lazy").setup({
    -- [Plugins]
    -- LSP
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'jay-babu/mason-nvim-dap.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'neovim/nvim-lspconfig' },
    {
        'nvimtools/none-ls.nvim',
        event = 'BufRead', -- !!
        dependencies = "gbprod/none-ls-shellcheck.nvim",
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        'R-nvim/R.nvim',
        ft = { 'qmd', 'rmd' },
    },
    --[[ {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
        },
    }, ]]
    {
        'mfussenegger/nvim-jdtls',
        dependencies = "mfussenegger/nvim-dap",
        ft = "java",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    require("jdtls").start_or_attach(require("plugins.config.jdtls").config)
                end,
            })
        end
    },
    -- CMP
    {
        'hrsh7th/nvim-cmp',
        event = 'BufRead',
        dependencies = { -- TODO
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            require 'plugins.config.cmp'
        end
    },
    {
        'xeluxee/competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        lazy = false,
        config = function()
            require 'plugins.config.competitest'
        end
    },
    -- Debugger
    { 'mfussenegger/nvim-dap' },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { "<Space>du", "<CMD>lua require('dapui').toggle()<CR>" },
        },
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require 'core.debugger'
        end
    },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'folke/neodev.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'mfussenegger/nvim-dap-python' },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        event = 'BufRead',
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = "rafamadriz/friendly-snippets"
    },
    -- Extended functionality
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'BurntSushi/ripgrep',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require 'plugins.config.telescope'
        end
    },
    {
        'jvgrootveld/telescope-zoxide',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
    },
    { 'nvim-telescope/telescope-ui-select.nvim' }, -- Presents native selection dialogs with telescope.
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    {
        'folke/zen-mode.nvim',
        keys = {
            { "<leader>z", "<CMD>ZenMode<CR>" },
        },
        config = function()
            require 'plugins.config.zen-mode'
        end
    },
    {
        'subnut/nvim-ghost.nvim',
        cmd = "GhostStart"
    },
    {
        'stevearc/dressing.nvim',
        event = 'BufRead',
    },
    {
        'kevinhwang91/nvim-ufo',
        keys = {
            { "<C-f>", "<CMD>lua require 'plugins.config.nvim-ufo'<CR>" },
        },
        dependencies = 'kevinhwang91/promise-async'
    },
    {
        'mbbill/undotree',
        keys = {
            { "<C-u>", "<CMD>UndotreeToggle<CR>" },
        },
    },
    {
        'preservim/tagbar',
        keys = {
            { "<C-t>", ":Tagbar<CR>" },
        },
    },
    { 'fidian/hexmode' },
    { 'mattn/emmet-vim' },
    -- { 'luk400/vim-jukit' },
    -- Enhancements
    { 'jbyuki/nabla.nvim' },
    {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
    {
        'famiu/bufdelete.nvim',
        event = { "BufRead", "BufAdd" },
    },
    {
        'Shatur/neovim-session-manager',
        lazy = false,
        config = function()
            require 'plugins.config.session-manager'
        end
    },
    {
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            require 'plugins.config.comment'
        end
    },
    {
        'Raimondi/delimitMate',
        event = { "BufRead", "BufAdd" },
    },
    {
        'phaazon/hop.nvim',
        keys = {
            { "S", "<CMD>HopWord<CR>" },
        },
        config = true
    },
    {
        event = { "BufRead", "BufAdd" },
        'svermeulen/vim-cutlass'
    },
    {
        'airblade/vim-rooter',
        config = function()
            require 'plugins.config.rooter'
        end
    },
    {
        'nacro90/numb.nvim',
        config = true
    },
    {
        'rickhowe/diffchar.vim',
        event = { "BufRead", "BufAdd" },
    }, -- Better diff mode
    {
        'tpope/vim-surround',
        event = { "BufRead", "BufAdd" },
    },
    -- Interface
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        config = function()
            require 'plugins.config.alpha'
        end
    },
    {
        'kyazdani42/nvim-tree.lua',
        keys = {
            { "<leader>e", "<CMD>NvimTreeToggle<CR>" },
        },
        config = function()
            require 'plugins.config.nvim-tree'
        end
    },
    {
        'akinsho/bufferline.nvim',
        event = { "BufRead", "BufAdd" },
        config = function()
            require 'plugins.config.bufferline'
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        event = { "BufRead", "BufAdd" },
        -- dependencies = "Exafunction/codeium.vim",
        config = function()
            require 'plugins.config.lualine'
        end
    },
    {
        'sudormrfbin/cheatsheet.nvim',
        keys = {
            { "?", "<CMD>Cheatsheet<CR>" },
        },
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require 'plugins.config.cheatsheet'
        end
    },
    -- Aesthetics
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            require 'plugins.config.grubvox-material'
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require 'plugins.config.treesitter'
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        -- event = 'BufReadPost',
        config = function()
            require 'plugins.config.nvim-treesitter-textobjects'
        end
    },
    {
        'brenoprata10/nvim-highlight-colors',
        event = { "BufRead", "BufAdd" },
        config = function()
            require 'plugins.config.nvim-highlight-colors'
        end
    },
    {
        'yuuhikaze/plantuml-syntax',
        ft = { 'puml', 'plantuml', 'uml', 'iuml' },
        config = function()
            vim.cmd(
                [[autocmd BufRead,BufNewFile * if !did_filetype() && getline(1) =~# '@startuml\>'| setfiletype plantuml | endif]])
            vim.cmd([[autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml,*.iuml set filetype=plantuml]])
        end
    },
    {
        'mtdl9/vim-log-highlighting',
        ft = 'log'
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require 'plugins.config.nvim-web-devicons'
        end
    },
}, {
    -- [Options]
    install = {
        colorscheme = { "gruvbox-material", "retrobox" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    ui = {
        backdrop = 100
    },
    defaults = {
        lazy = true
    }
})

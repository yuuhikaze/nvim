-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
end
vim.cmd [[packadd packer.nvim]]

local installed, packer = pcall(require, "packer")
if not installed then
    return
end

-- Displays packer on a pop-up window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "" }
        end,
        prompt_border = "",
    },
    git = {
        clone_timeout = 600,
    },
    auto_clean = true,
}

-- Plugins to install
return packer.startup(function(use)
    -- Package manager
    use { 'wbthomason/packer.nvim' }
    -- LSP
    use { 'williamboman/mason.nvim' }
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'jay-babu/mason-nvim-dap.nvim' }
    use { 'WhoIsSethDaniel/mason-tool-installer.nvim' }
    use {
        'nvimtools/none-ls.nvim',
        requires = "gbprod/none-ls-shellcheck.nvim",
    }
    use { 'mfussenegger/nvim-jdtls' }
    -- CMP
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use {
        'Exafunction/codeium.vim',
        config = function()
            require 'plugins.config.codeium'
        end
    }
    use {
        'xeluxee/competitest.nvim',
        requires = 'MunifTanjim/nui.nvim',
        config = function()
            require 'plugins.config.competitest'
        end
    }
    -- Debugger
    use { 'mfussenegger/nvim-dap' }
    use {
        'rcarriga/nvim-dap-ui',
        requires = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        }
    }
    use { 'theHamsta/nvim-dap-virtual-text' }
    use { 'folke/neodev.nvim' }
    use { 'nvim-telescope/telescope-dap.nvim' }
    use { 'mfussenegger/nvim-dap-python' }
    -- Snippets
    use {
        "L3MON4D3/LuaSnip",
        tag = "v2.*",
        run = "make install_jsregexp"
    }
    use { "rafamadriz/friendly-snippets" }
    use { "saadparwaiz1/cmp_luasnip" }
    -- Extended functionality
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'BurntSushi/ripgrep',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require 'plugins.config.telescope'
        end
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim', -- Improves sorting performance
        run = 'make',
    }
    use {
        'jvgrootveld/telescope-zoxide',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
    }
    use {
        'nvim-telescope/telescope-ui-select.nvim', -- Presents native selection dialogs with telescope
        config = function()
            require 'plugins.config.telescope-ui-select'
        end
    }
    use { 'nvim-telescope/telescope-live-grep-args.nvim' }
    use {
        'folke/zen-mode.nvim',
        config = function()
            require 'plugins.config.zen-mode'
        end
    }
    use {
        'ZSaberLv0/eregex.vim',
        config = function()
            require 'plugins.config.eregex'
        end
    }
    use { 'stevearc/dressing.nvim' }
    use { 'mbbill/undotree' }
    use { 'preservim/tagbar' }
    use { 'fidian/hexmode' }
    use { 'mattn/emmet-vim' }
    -- Enhancements
    use {
        'Shatur/neovim-session-manager',
        config = function()
            require 'plugins.config.session-manager'
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require 'plugins.config.comment'
        end
    }
    use { 'Raimondi/delimitMate' }
    use {
        'phaazon/hop.nvim',
        config = function()
            require 'plugins.config.hop'
        end
    }
    use { 'svermeulen/vim-cutlass' }
    use {
        'airblade/vim-rooter',
        config = function()
            require 'plugins.config.rooter'
        end
    }
    use {
        'vim-scripts/LargeFile',
        config = function()
            require 'plugins.config.large-file'
        end
    }
    use {
        'nacro90/numb.nvim',
        config = function()
            require 'plugins.config.numb'
        end
    }
    use {
        'VonHeikemen/searchbox.nvim',
        requires = {
            'MunifTanjim/nui.nvim'
        }
    }
    use { 'rickhowe/diffchar.vim' }    -- Better diff mode
    use { 'tpope/vim-surround' }
    use { 'lewis6991/impatient.nvim' } -- Improves overall performance
    -- Interface
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'plugins.config.alpha'
        end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require 'plugins.config.nvim-tree'
        end
    }
    use {
        'akinsho/bufferline.nvim',
        config = function()
            require 'plugins.config.bufferline'
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require 'plugins.config.lualine'
        end
    }
    use {
        'sudormrfbin/cheatsheet.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require 'plugins.config.cheatsheet'
        end
    }
    -- Aesthetic
    use { 'sainnhe/gruvbox-material' }
    -- use { 'rebelot/kanagawa.nvim' }
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require 'plugins.config.treesitter'
        end
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'plugins.config.colorizer'
        end
    }
    use { 'mtdl9/vim-log-highlighting' }
    use { 'ryanoasis/vim-devicons' }

    -- Set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

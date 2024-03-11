-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

-- add list of plugins to install
return packer.startup(function(use)
    -- packer can manage itself
    use("wbthomason/packer.nvim")

    -- lua functions for other plugins
    use("nvim-lua/plenary.nvim")

    -- color scheme
    use("tjdevries/colorbuddy.nvim")
    use("svrana/neosolarized.nvim")

    -- vim tmux navigator
    --use("christoomey/vim-tmux-navigator")

    -- maximize vim windows
    use("szw/vim-maximizer")

    -- line and block comments
    use("numToStr/Comment.nvim")

    -- file explorer
    use("nvim-tree/nvim-tree.lua")

    -- icons
    use("nvim-tree/nvim-web-devicons")

    -- status line
    use("nvim-lualine/lualine.nvim")

    -- fuzzy finding w/ telescope
    --use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", tag = "0.1.4" }) -- fuzzy finder

    -- auto completion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")

    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for auto completion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- managing and adding lsp servers
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- configuring lsp servers
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("onsails/lspkind.nvim") -- add icons to auto completion

    -- lspsaga
    use({
        --"glepnir/lspsaga.nvim",
        "nvimdev/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    })

    -- rust
    use("simrat39/rust-tools.nvim")

    -- minimap
    use("gorbit99/codewindow.nvim")

    -- restore last cursor postion
    use("ethanholz/nvim-lastplace")

    -- automatically close parenthesis etc.
    use("windwp/nvim-autopairs")

    -- support for ipynb files (not yet working)
    --use("meatballs/notebook.nvim")
    --use("meatballs/magma-nvim")

    -- tabs
    use({"akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons"})
    use("moll/vim-bbye") -- for closing tabs

    -- persistance
    use("olimorris/persisted.nvim")

    -- trouble
    use({"folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons"})

    -- indent blank lines
    use("lukas-reineke/indent-blankline.nvim")

    -- git signs
    use("lewis6991/gitsigns.nvim")

    -- toggle term
    use("akinsho/toggleterm.nvim")

    -- nvim-dap (debugger adapter protocol)
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use("theHamsta/nvim-dap-virtual-text")
    use("rcarriga/nvim-dap-ui")

    -- copilot
    use("zbirenbaum/copilot.lua")
    use("zbirenbaum/copilot-cmp")

    if packer_bootstrap then
        require("packer").sync()
    end
end)


-- ignore default config and plugins
vim.opt.runtimepath:remove(vim.fn.expand('~/.config/nvim'))
vim.opt.packpath:remove(vim.fn.expand('~/.local/share/nvim/site'))

-- append test directory
local test_dir = '/tmp/nvim-config'
vim.opt.runtimepath:append(vim.fn.expand(test_dir))
vim.opt.packpath:append(vim.fn.expand(test_dir))

-- install packer
local install_path = test_dir .. '/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd('packadd packer.nvim')
    install_plugins = true
end

local packer = require('packer') 

packer.init({
    package_root = test_dir .. '/pack',
    compile_path = test_dir .. '/plugin/packer_compiled.lua'
})

packer.startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- lua functions for other plugins
    use("nvim-lua/plenary.nvim")

    -- -- managing and adding lsp servers
    -- use("williamboman/mason.nvim")
    -- use("williamboman/mason-lspconfig.nvim")
    -- use("neovim/nvim-lspconfig")
    -- use("hrsh7th/cmp-nvim-lsp")
    --
    -- -- lspsaga
    -- use({
    --     "glepnir/lspsaga.nvim",
    --     branch = "main",
    --     requires = {
    --         { "nvim-tree/nvim-web-devicons" },
    --         { "nvim-treesitter/nvim-treesitter" },
    --     },
    -- })

    use {'neoclide/coc.nvim', branch = 'release'}

    -- tabs
    use("akinsho/bufferline.nvim")
    use("lewis6991/gitsigns.nvim")
    use("moll/vim-bbye") -- for closing tabs

    -- persistance
    use("olimorris/persisted.nvim")

    if install_plugins then
        packer.sync()
    end
end)


-- mason setup
local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return 
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return 
end

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        "pyright",
        "lua_ls",
    }
})

-- attach lsps
local on_attach = function(client, bufnr)
     local opts = { noremap = true, silent = true }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- nvim-treesitter setup
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup({
    -- enable syntax highlighting
    highlight = {
        enable = true,
    },
    -- enable indentation
    indent = { enable = true },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = { enable = true },
    -- ensure these language parsers are installed
    ensure_installed = {
      "python",
      "lua",
      "vim",
    },
    -- auto install above language parsers
    auto_install = true,
})

-- bufferline setup
 local status, bufferline = pcall(require, "bufferline")
if not status then
    return
end

bufferline.setup({
    options = {
        mode = "buffers",
        close_command = "Bdelete! %d", 
    },
})

-- persisted setup
local status, persisted = pcall(require, "persisted")
if not status then
    return
end

persisted.setup()


print("Hello World")



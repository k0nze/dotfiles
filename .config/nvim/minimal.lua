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
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")


    if install_plugins then
        packer.sync()
    end
end)

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
    return
end

require("luasnip/loaders/from_vscode")


vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-q>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    sources = {
        { name = "nvim_lsp" }, -- lsp 
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
    },
})


-- mason
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
        --"asm_lsp",
        --"bashls",
        --"clangd",
        --"cmake",
        --"dockerls",
        --"grammarly",
        --"jsonls",
        --"ltex",
        --"lua_ls",
        --"marksman",
        "rust_analyzer",
        "pyright",
        "lua_ls",
    }
})

-- 
local on_attach = function(client, bufnr)
     local opts = { noremap = true, silent = true }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

print("Hello World")

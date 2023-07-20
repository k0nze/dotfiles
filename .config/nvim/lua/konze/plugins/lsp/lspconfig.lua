local keymap = vim.keymap -- for conciseness

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- keymaps when lsp is enabled
    keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
    keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
    keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", opts) -- code action
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    keymap.set("n", "gR", "<cmd>Lspsaga rename<CR>", opts) -- rename in entire project
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

local python_root_files = {
    'pyproject.toml',
    'setup.py',
    'requirements.txt',
    'pyrightconfig.json',
}

lspconfig["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern(unpack(python_root_files))
})

lspconfig["clangd"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig["cmake"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig["ltex"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
    filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
        settings = {
            ltex = {
                enabled = { "latex", "tex", "bib", "markdown", },
                language = "en-US",
                diagnosticSeverity = "information",
                sentenceCacheSize = 2000,
            },
        },
})


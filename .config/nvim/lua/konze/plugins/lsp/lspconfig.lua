local keymap = vim.keymap -- for conciseness

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- keymaps when lsp is enabled
    keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
    keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
    keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", opts) -- code action
    -- keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    keymap.set("n", "gR", "<cmd>Lspsaga rename<CR>", opts) -- rename in entire project
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig")["clangd"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig")["cmake"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})


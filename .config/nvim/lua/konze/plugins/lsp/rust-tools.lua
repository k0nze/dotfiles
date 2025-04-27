local status, rust_tools = pcall(require, "rust-tools")
if not status then
    return
end

rust_tools.setup({
    --server = {
    --    on_attach = function(_, bufnr)
    --        -- hover actions
    --        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    --        -- code action groups
    --        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    --    end,
    --},
})


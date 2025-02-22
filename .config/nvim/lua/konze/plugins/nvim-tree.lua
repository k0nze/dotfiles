local status, nvimtree = pcall(require, "nvim-tree")
if not status then
    return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
    -- disable window_picker for
    -- explorer to work well with
    -- window splits
    actions = {
        open_file = {
            window_picker = {
                enable = true,
            },
        },
    },
    filters = {
        custom = { ".git", "__pycache__" },
        exclude = { ".gitignore", ".venv", ".github" }
    }
})


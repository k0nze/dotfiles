return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        {
            'SmiteshP/nvim-navic',
            opts = {
                lsp = { auto_attach = true },
                click = false,
            },
        },
    },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'solarized_dark',
                disabled_filetypes = {"neo-tree"}
            },
            sections = {
                lualine_c = { 'filename', 'navic' },
            },
        })
    end
}


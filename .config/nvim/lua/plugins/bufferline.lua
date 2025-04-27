return {
    'akinsho/bufferline.nvim', 
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
        require('bufferline').setup({
            options = {
                mode = "buffers",
                close_command = "Bdelete! %d", 
                separator_style = "slant",
                -- separator_style customization: https://github.com/akinsho/bufferline.nvim/issues/555#issuecomment-1250093105
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "left",
                        separator = true,
                    }
                },
            }
        })
    end
}

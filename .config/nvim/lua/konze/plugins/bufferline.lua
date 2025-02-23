vim.opt.termguicolors = true

local status, bufferline = pcall(require, "bufferline")
if not status then
    return
end

bufferline.setup({
    options = {
        mode = "buffers",
        close_command = "Bdelete! %d", 
        separator_style = "slant",
        -- separator_style customization: https://github.com/akinsho/bufferline.nvim/issues/555#issuecomment-1250093105
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true,
            }
        },
    },
})


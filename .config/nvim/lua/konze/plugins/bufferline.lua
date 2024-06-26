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

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-q>", "<Cmd>Bdelete<CR>", opts)
--keymap("n", "<S-n>", "<Cmd>enew<CR>", opts)
keymap("n", "<S-p>", "<C-o>", opts)
keymap("n", "<S-n>", "<C-i>", opts)

keymap("n", "<C-l>", "<Cmd>BufferLineMoveNext<CR>", opts)
keymap("n", "<C-h>", "<Cmd>BufferLineMovePrev<CR>", opts)

local keymap = vim.keymap



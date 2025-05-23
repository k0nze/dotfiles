vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- if a char is deleted with x the deleted char is not stored in a register
--keymap.set("n", "x", "_x")

-- leave insert mode

-- split windows vertically
keymap.set("n", "<leader>%", "<C-w>v")
-- split windows horizontally
keymap.set("n", '<leader>"', "<C-w>s")
-- make split windows equal width
keymap.set("n", "<leader>=", "<C-w>=")
-- close current split window
keymap.set("n", "<C-d>", ":close<CR>")

-- move to window above
keymap.set("n", "<leader>k", "<C-w><up>")
-- move to window below
keymap.set("n", "<leader>j", "<C-w><down>")
-- move to window on the left
keymap.set("n", "<leader>l", "<C-w><right>")
-- move to window on the right
keymap.set("n", "<leader>h", "<C-w><left>")
-- maximize / restore current window (vim-maximizer)
keymap.set("n", "<leader>m", ":MaximizerToggle<CR>")

-- save file
keymap.set("n", "<leader>s", ":w<CR>")
-- close file
keymap.set("n", "<leader>q", ":q<CR>")

-- decrase number
keymap.set("n", "<C-s>", "<C-x>")

-- turn off highlights
keymap.set("n", "<C-n>", ":nohl<CR>")

-- nvim-tree
keymap.set("n", "<leader>o", ":Neotree toggle<CR>")

-- disable recording
keymap.set("n", "q", "<Nop>")

-- telescope
keymap.set("n", "tf", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "ts", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "tc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "tb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "th", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- set keymap to lua function
--vim.keymap.set("n", "hh", function()  end)

-- bufferline
local opts = { noremap = true, silent = true }

keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", opts)
keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", opts)
keymap.set("n", "<S-q>", "<Cmd>Bdelete<CR>", opts)
--keymap.set("n", "<S-n>", "<Cmd>enew<CR>", opts)
keymap.set("n", "<S-p>", "<C-o>", opts)
keymap.set("n", "<S-n>", "<C-i>", opts)

keymap.set("n", "<C-l>", "<Cmd>BufferLineMoveNext<CR>", opts)
keymap.set("n", "<C-h>", "<Cmd>BufferLineMovePrev<CR>", opts)


-- jump to last cursor position
keymap.set("n", "gb", "<C-o>", opts)

-- wrapping
keymap.set("n", "<leader>w", "<Cmd>ToggleWrapMode<CR>", opts)

-- tiny code actions
keymap.set("n", "ga", function()
    require("tiny-code-action").code_action()
end, opts)


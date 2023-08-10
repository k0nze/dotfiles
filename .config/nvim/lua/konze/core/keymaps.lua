vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- if a char is deleted with x the deleted char is not stored in a register
--keymap.set("n", "x", "_x")

-- leave insert mode
-- TODO keymap.set("n", "<leader>c", "<C-c>")

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

-- nvim-tree
keymap.set("n", "<leader>o", ":NvimTreeToggle<CR>")

-- disable recording
keymap.set("n", "q", "<Nop>")

-- telescope
keymap.set("n", "tf", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "ts", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "tc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "tb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
-- keymap.set("n", "th", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- set keymap to lua function
--vim.keymap.set("n", "hh", function()  end)

-- save session, save all unsaved buffers, and close nvim
keymap.set("n", "<C-S-q>", ":execute 'NvimTreeClose' | execute 'SessionSave' | wqa<CR>") 

-- turn off highlights
keymap.set("n", "<C-n>", ":nohl<CR>")

-- nvim-dap debugging
keymap.set("n", "<leader>d", ":lua require('dapui').toggle()<cr>")
keymap.set("n", "db", ":lua require('dap').toggle_breakpoint()<cr>")
keymap.set("n", "dc", ":lua require('dap').continue()<cr>")
keymap.set("n", "dl", ":lua require('dap').run_last()<cr>")
keymap.set("n", "do", ":lua require('dap').step_over()<cr>")
keymap.set("n", "di", ":lua require('dap').step_into()<cr>")
keymap.set("n", "dq", ":lua require('dap').disconnect({ terminateDebuggee = true })<cr>")


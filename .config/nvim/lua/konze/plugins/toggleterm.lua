local status, toggleterm = pcall(require, "toggleterm")
if not status then
    return
end

toggleterm.setup({})

local keymap = vim.keymap

keymap.set("n", "<leader>t", "<cmd>ToggleTerm size=30 dir=. direction=horizontal<CR>")
--keymap.set("n", "<leader>e", "<cmd>TermExec cmd=\"ls\"<CR>")

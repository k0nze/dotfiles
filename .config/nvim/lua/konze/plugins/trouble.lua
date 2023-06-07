local status, trouble = pcall(require, "trouble")
if not status then
    return
end

trouble.setup({

})

local keymap = vim.keymap

--keymap.set("n", "<leader>t", "<cmd>TroubleToggle<CR>")


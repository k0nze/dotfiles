local codewindow_status, codewindow = pcall(require, "codewindow")
if not codewindow_status then
    return
end

codewindow.setup({
     auto_enable = false,
})
codewindow.apply_default_keybinds()

local keymap = vim.keymap

--keymap.set("n", "<leader>mq", codewindow.close_minimap()) 

-- show minimap for certain file extension 
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--     pattern = {"*.py"},
--     callback = function() codewindow.open_minimap() end,
-- })


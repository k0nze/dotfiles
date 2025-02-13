local status, micropython = pcall(require, "micropython")
if not status then
    return
end

micropython.setup()

--local keymap = vim.keymap
--keymap.set("n", "<leader>r", "<cmd>MPRun<CR>")
vim.keymap.set("n", "<leader>r", require("micropython_nvim").run)

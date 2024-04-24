vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
    end,
})

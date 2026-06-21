local opt = vim.opt -- for conciseness

-- line number
-- opt.relativenumber = true
opt.number = true 

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
--opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- Reload files when they are changed outside of Neovim.
opt.autoread = true

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- - <- dash is considered as part of the word (e.g. for jumping over words using w)
opt.iskeyword:append("-")

-- ruler
opt.colorcolumn = "88"

vim.filetype.add({
    extension = {
        v = "verilog",
        vh = "verilog",
        sv = "systemverilog",
        svh = "systemverilog",
    },
})

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

local autoread_group = vim.api.nvim_create_augroup("konze-autoread", { clear = true })
local autoread_watchers = {}
local uv = vim.uv or vim.loop

local function close_autoread_watcher(bufnr)
    local watcher = autoread_watchers[bufnr]

    if watcher then
        watcher:stop()
        watcher:close()
        autoread_watchers[bufnr] = nil
    end
end

local function watch_buffer_for_external_changes(bufnr)
    close_autoread_watcher(bufnr)

    if vim.bo[bufnr].buftype ~= "" then
        return
    end

    local path = vim.api.nvim_buf_get_name(bufnr)

    if path == "" or vim.fn.filereadable(path) ~= 1 then
        return
    end

    local dir = vim.fn.fnamemodify(path, ":h")
    local watcher = uv.new_fs_event()

    local err = watcher:start(dir, {}, function()
        vim.schedule(function()
            if
                vim.api.nvim_buf_is_valid(bufnr)
                and vim.fn.filereadable(path) == 1
                and not vim.bo[bufnr].modified
            then
                vim.cmd("silent! checktime " .. bufnr)
            end
        end)
    end)

    if err and err ~= 0 then
        watcher:close()
    else
        autoread_watchers[bufnr] = watcher
    end
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    group = autoread_group,
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("silent! checktime")
        end
    end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = autoread_group,
    callback = function()
        vim.notify("Reloaded file changed outside Neovim", vim.log.levels.INFO)
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufFilePost" }, {
    group = autoread_group,
    callback = function(event)
        watch_buffer_for_external_changes(event.buf)
    end,
})

vim.api.nvim_create_autocmd("BufUnload", {
    group = autoread_group,
    callback = function(event)
        close_autoread_watcher(event.buf)
    end,
})

for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
        watch_buffer_for_external_changes(bufnr)
    end
end

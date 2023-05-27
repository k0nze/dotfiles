-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
     return
end

saga.setup({
    -- keybinds for navigation in lspsaga window
    scroll_preview = { 
        scroll_down = "<C-f>", 
        scroll_up = "<C-b>" 
    },
    -- use enter to open file with definition preview
    definition = {
        edit = "<CR>",
    },
    -- customize breadcrumb menu
    symbol_in_winbar = {
        enable = true,
        separator = "  ",
        ignore_patterns={},
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = false,
        color_mode = true,
    },
})

local status, lualine = pcall(require, "lualine")
if not status then
    return
end

local lualine_solarized_dark = require("lualine.themes.solarized_dark")

local custom_colors = {
    yellow = "#b58900" -- neosolarized yellow
}

lualine_solarized_dark.command = {
    a = {
        gui = "bold",
        bg = custom_colors.yellow,
        fg = lualine_solarized_dark.normal.a.fg
    }
}

lualine.setup({
    options = {
        theme = lualine_solarized_dark,
        disabled_filetypes = { "packer", "NvimTree" }
    }
})


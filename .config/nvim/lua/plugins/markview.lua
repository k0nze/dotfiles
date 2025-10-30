-- For `plugins/markview.lua` users.
return {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- For blink.cmp's completion
    -- source
    dependencies = {
        "saghen/blink.cmp",
        "nvim-tree/nvim-web-devicons",
        "echasnovski/mini.icons"
    },
    preview = {
        icon_provider = "devicons", -- "mini" or "devicons"
    },
};

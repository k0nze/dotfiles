-- adapted from: https://github.com/jakobwesthoff/nvim-from-scratch/blob/session/04/lua/plugins/fzflua.lua

return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys={
        {
            "ts",
            function() require('fzf-lua').live_grep() end,
            desc="Find by grepping in project directory"
        },
        {
            "tf",
            function() require('fzf-lua').files() end,
            desc="Find Files in project directory"
        },
        {
            "tw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "[F]ind current [W]ord",
        },
    }
}

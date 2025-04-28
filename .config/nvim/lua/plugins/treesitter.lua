return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "json",
                "yaml",
                "markdown",
                "markdown_inline",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "python",
                "rust",
                "make",
                "cpp",
                "c",
                "cmake",
                "latex",
                "bibtex",
            },
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "s", -- set to `false` to disable one of the mappings
                    node_incremental = "s",
                    scope_incremental = false,
                    node_decremental = "<S-s>",
                },
            },
        })
    end
}

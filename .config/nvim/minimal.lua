-- ignore default config and plugins
vim.opt.runtimepath:remove(vim.fn.expand('~/.config/nvim'))
vim.opt.packpath:remove(vim.fn.expand('~/.local/share/nvim/site'))

-- append test directory
local test_dir = '/tmp/nvim-config'
vim.opt.runtimepath:append(vim.fn.expand(test_dir))
vim.opt.packpath:append(vim.fn.expand(test_dir))

-- install packer
local install_path = test_dir .. '/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd('packadd packer.nvim')
    install_plugins = true
end

local packer = require('packer') 

packer.init({
    package_root = test_dir .. '/pack',
    compile_path = test_dir .. '/plugin/packer_compiled.lua'
})

packer.startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- lua functions for other plugins
    use("nvim-lua/plenary.nvim")
    
    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", tag = "0.1.1" }) -- fuzzy finder


    if install_plugins then
        packer.sync()
    end
end)

-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
    return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
    return
end

-- configure telescope
telescope.setup({
    -- configure custom mappings
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                ["jkk"] = actions.close, -- send selected to quickfixlist
            },
        },
    },
})

telescope.load_extension("fzf")

-- telescope keymap
vim.keymap.set("n", "tf", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
vim.keymap.set("n", "ts", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
vim.keymap.set("n", "tc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
vim.keymap.set("n", "tb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
vim.keymap.set("n", "th", "<cmd>Telescope help_tags<cr>") -- list available help tags


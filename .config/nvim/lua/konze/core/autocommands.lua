-- documentation: https://neovim.io/doc/user/lua-guide.html#lua-guide-autocommands

--vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--    pattern = {"*.py"},
--    callback = function() print("Entering a python file") end,
--})


-- function which checkis if a file exists
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- check if the current directory is a git repository and open nvim-tree
function show_nvim_tree_and_restore_session_in_git_repository()
    if file_exists(".git") then
        vim.api.nvim_command("SessionLoad")
        vim.api.nvim_command("NvimTreeOpen")
        --key = vim.api.nvim_replace_termcodes('<C-w><right>', true, true, true)
        --vim.api.nvim_feedkeys(key, "n", 1)
        --print(vim.fn.expand("%"))
        --buf = vim.fn.expand("%")
        --vim.api.nvim_command("Bdelete! " .. buf)
    end
end 

-- when opening nvim inside a directory that contains a .git directory the nvim-tree is opened 
vim.api.nvim_create_autocmd({"VimEnter"}, {
    pattern = {"*"}, 
    callback = function() show_nvim_tree_and_restore_session_in_git_repository() end,
})



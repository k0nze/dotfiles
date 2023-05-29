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
function show_nvim_tree_in_git_repository()
    if file_exists(".git") then
        vim.api.nvim_command("NvimTreeOpen")
    end
end 


vim.api.nvim_create_autocmd({"VimEnter"}, {
    pattern = {"*"}, 
    callback = function() show_nvim_tree_in_git_repository() end,
})


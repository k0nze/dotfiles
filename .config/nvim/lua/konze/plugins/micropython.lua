local status, micropython = pcall(require, "micropython")
if not status then
    return
end

micropython.setup({

})

local ignore_list = {
    ['.git'] = true,
    ['requirements.txt'] = true,
    ['.ampy'] = true,
    ['.vscode'] = true,
    ['.gitignore'] = true,
    ['project.pymakr'] = true,
    ['env'] = true,
    ['venv'] = true,
    ['__pycache__'] = true,
    ['.python-version'] = true,
    ['.micropy/'] = true,
    ['micropy.json'] = true,
}

local status, openscad = pcall(require, "openscad")
if not status then
    return
end

openscad.setup()

-- https://github.com/salkin-mada/openscad.nvim

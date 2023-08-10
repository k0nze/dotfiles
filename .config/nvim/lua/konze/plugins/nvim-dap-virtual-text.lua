local status, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status then
    return
end

dap_virtual_text.setup()

local status, lsb_signature = pcall(require, "lsp_signature")
if not status then
    return
end

lsb_signature.setup()


local status, chatgpt = pcall(require, "chatgpt")
if not status then
    return
end

-- check if an API is set
local api_key = os.getenv("OPENAI_API_KEY")

if api_key == nil then
    chatgpt.setup()
end


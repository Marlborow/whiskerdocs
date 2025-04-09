local M = {}
function M.run(line, plugins)

    local function log(plugin, extra)
        if not plugin then return end
        print("[Interpreter]: " .. (plugin.__name or "unknown") .. extra)
    end

    local result = line

    for _,loaded in ipairs(plugins) do
        if loaded.interprete then
            result = loaded.interprete(result)
        end
    end

    return result .. "\n"
end

return M;

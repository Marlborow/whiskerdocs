local M = {}
function M.run(line, plugins)

    local function log(plugin, extra)
        if not plugin then return end
        print("[Interpreter]: " .. (plugin.__name or "unknown") .. extra)
    end

    local result = line:match("^%s*(.-)%s*$")

    for _,loaded in ipairs(plugins) do
        if not loaded.interprete then goto try_interprete_next_plugin end

        log(M.activePlugin," => (".. result..")")
        result = loaded.interprete(result)

    ::try_interprete_next_plugin::
    end
    return result
end

return M;

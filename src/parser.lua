local M = {}
M.activePlugin = nil

local function tryBeginPlugin(plugin, line)
    if not plugin.begin then return false, nil end
    return plugin.begin(line)
end

function M.run(line, plugins)

    local function log(plugin, extra)
        if not plugin then return end
        print("[Interpreter]: " .. (plugin.__name or "unknown") .. extra)
    end

    --Is it a new plugin?
    for _, loaded in ipairs(plugins) do
        local want, result = tryBeginPlugin(loaded, line)
        if want then
            M.activePlugin = {
                plugin = loaded,
                parent = M.activePlugin,
                __name = loaded.__name or "unknown",
                buffer = {}
            }
            return result
        end
    end

    --Is active plugin?
    if M.activePlugin then
        local result, done = M.activePlugin.plugin.continue(line)
        if not done then
            --loop until we get to the head plugin (most parent)
            parent.buffer = parent.buffer .. result
        end
        log(M.activePlugin," released control.")

        M.activePlugin = M.activePlugin.parent or nil
        return result
    end

    --No active or new Plugin
    local cleanLine = line:match("^%s*(.-)%s*$")
    local result = cleanLine

    for _,loaded in ipairs(plugins) do
        if loaded.interprete then
            log(M.activePlugin," => (".. result..")")
            result = loaded.interprete(result)
        end
    end
    return result
end

return M;

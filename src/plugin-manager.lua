local M = {}
M.plugins = {}
M.loadedPlugins = {}

local function use(spec)
    if type(spec) == "string" then
        table.insert(M.plugins, {name = spec})
    else if type(spec) == "table" then
            table.insert(M.plugins, spec)
        else
            error("Invalid use() format.")
        end
    end
end

local function loadPlugins()
    for _, plugin in ipairs(M.plugins) do
        local ok, mod = pcall(require, plugin.name)
        if ok then
            mod.__name = plugin.name
            table.insert(M.loadedPlugins, mod)
            print("[Plugin Manager] Loaded plugin: " .. plugin.name)
            if mod.init then mod.init() end
        else
            print("Failed to load plugin:", plugin.name)
        end
    end
end


function M.startup(config)
    local compiled = dofile(config)
    compiled(use)
    loadPlugins()

    if M.plugins == 0 then
        print("[Plugin Manager] No plugins to load.")
        return false
    end
    return true
end

return M

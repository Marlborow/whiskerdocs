local M = {}
M.plugins = {}
M.loadedPlugins = {}

-- Create logs directory if it doesn't exist
local function ensureLogDir()
    os.execute("mkdir -p logs")
end

-- Get current timestamp for filename
local function getTimestamp()
    return os.date("%Y-%m-%d_%H-%M-%S")
end

-- Global log handle
local logFile = nil

local function use(spec)
    if type(spec) == "string" then
        table.insert(M.plugins, {name = spec})
    elseif type(spec) == "table" then
        table.insert(M.plugins, spec)
    else
        error("Invalid use() format.")
    end
end

local function log(msg)
    if logFile then
        logFile:write(msg .. "\n")
    end
end

local function loadPlugins()
    ensureLogDir()
    local logPath = "logs/" .. getTimestamp() .. ".log"
    logFile = io.open(logPath, "w")

    for _, plugin in ipairs(M.plugins) do
        local ok, mod = pcall(require, plugin.name)
        if ok then
            mod.__name = plugin.name
            table.insert(M.loadedPlugins, mod)
            log("[Plugin Manager] Loaded plugin: " .. plugin.name)
            if mod.init then mod.init() end
        else
            log("Failed to load plugin: " .. plugin.name)
        end
    end

    if logFile then
        logFile:close()
        logFile = nil
    end
end

function M.startup(config)
    local compiled = dofile(config)
    compiled(use)
    loadPlugins()

    if #M.plugins == 0 then
        print("[Plugin Manager] No plugins to load.")
        return false
    end
    return true
end

return M


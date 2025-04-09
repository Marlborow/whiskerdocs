package.path = "./?.lua;./plugins/?.lua;" .. package.path

Pluginmanager = require "src.plugin-manager"
Parser        = require "src.parser"

Interpreter = {}

local logFile = nil
local logPath = nil

-- Create logs directory if needed
local function ensureLogDir()
    os.execute("mkdir -p logs")
end

-- Get or reuse timestamped log path
local function getOrCreateLogPath()
    if logPath then return logPath end
    local files = io.popen("ls logs/*.log 2>/dev/null"):lines()
    local latest = nil
    for file in files do latest = file end
    if latest then
        logPath = latest
    else
        logPath = "logs/" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".log"
    end
    return logPath
end

local function openLog()
    ensureLogDir()
    local path = getOrCreateLogPath()
    logFile = io.open(path, "a")
end

local function log(msg)
    if logFile then logFile:write(msg .. "\n") end
end

local function closeLog()
    if logFile then logFile:close() logFile = nil end
end

local function initialize()
    return Pluginmanager.startup("config.lua")
end

local function checkForComment(line)
    return line:match("^%s*;;") ~= nil
end

local function parse(line)
    if checkForComment(line) then return "" end
    return Parser.run(line, Pluginmanager.loadedPlugins)
end

function Interpreter.run(file, out)
    openLog()

    if not file then
        log("[Interpreter]: Failed to load file '" .. tostring(file) .. "'")
        closeLog()
        return false
    end

    if not out then
        log("[Interpreter]: Failed to open output")
        closeLog()
        return false
    end

    log("[Interpreter]: Starting parse...")
    initialize()

    for line in file:lines() do
        out:write(parse(line))
    end

    log("[Interpreter]: Completed successfully.")
    closeLog()
    return true
end

return Interpreter


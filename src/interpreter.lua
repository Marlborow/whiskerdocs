package.path = "./?.lua;./plugins/?.lua;" .. package.path

Pluginmanager = require "src.plugin-manager"
Parser        = require "src.parser"

Interpreter = {}

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
    if not file then
        print("[Interpreter]: Failed to load file '" .. file .. "'")
        return false
    end

    if not out then
        print("[Interpreter]: Failed to load file '" ..  out .. "'")
        return false
    end
    initialize();



    for line in file:lines() do
        out:write(parse(line))
    end
    return true
end

return Interpreter;

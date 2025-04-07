local M = {}
M.log = false
require "src.libs.cstring"
require "src.interpreter"

local function checkArguments()
    if #arg < 1 or #arg > 1 then
        print("Usage: lua " .. arg[0] .. " <file.wd>")
        return false
    end
    return true
end

local function checkFileType()

    local wrongFS = false;

    local extension = strrchr(arg[1], ".")
    if not extension then wrongFS = true end
    if(extension ~= ".wd") then wrongFS = true  end

    if wrongFS then
        print("Filetype input is of wrong type. Accepted type is '*.wd'")
        return false
    end

    return true
end

local function embeddHTMLData(file, opt)

    if not file then return false end
    opt = string.lower(opt)

    local function writeToFile(src)
        local inputSrc = io.open(src, "r")
        if not inputSrc then
            print("Init::embeddHTML: Faild to open inputSrc")
            return false;
        end

        file:write(inputSrc:read("a"))
        inputSrc:close()
    end

    local opt_table = {
        ["header"] = function () writeToFile("src/html/default-heading.html") end,
        ["footer"] = function () writeToFile("src/html/default-footer.html") end
    }

    local validJump = opt_table[opt]
    if (validJump) then opt_table[opt]() return true end

    print("Failed on init::embeddHTML")
    return false
end

function M.run()
    if checkArguments() == false then return false end
    if checkFileType()  == false then return false end


    local File = io.open(arg[1], "r")
    if(not File) then
        print("Failed to load file: " .. arg[1])
        return false
    end

    local Output = io.open(string.sub(arg[1], 1, #arg[1] - 3) .. ".html","w")

    if not embeddHTMLData(Output,"Header")  then return false end
    if not Interpreter.run(File, Output)  then return false end    if not embeddHTMLData(Output, "Footer") then return false end

    io.close(Output)
    io.close(File)
    return true;
end

return M;

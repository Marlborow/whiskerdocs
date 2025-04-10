local M = {}
local active = false

local math_macros = {
  ["\\lam"] = "\\lambda",
  ["\\eps"] = "\\epsilon",
  ["\\del"] = "\\delta",
  ["\\inf"] = "\\infty",
  ["\\R"]   = "\\mathbb{R}",
  ["\\Z"]   = "\\mathbb{Z}",
  ["\\N"]   = "\\mathbb{N}",
  ["\\Q"]   = "\\mathbb{Q}",
  ["%*"]    = "\\cdot",
}

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function expand_macros(s)
    for k, v in pairs(math_macros) do
        s = s:gsub(k, v)
    end
    return s
end

local function escape_spaces(line, add_trailing)
    local out = {}
    local started = false
    for c in line:gmatch(".") do
        if c == " " and started then
            table.insert(out, "\\ ")
        else
            table.insert(out, c)
            if c ~= " " then started = true end
        end
    end
    if add_trailing then
        table.insert(out, "\\ ")
    end
    return table.concat(out)
end

local function process_math_line(content)
    local result = {}
    local i = 1
    local len = #content
    local in_text = false
    local buffer = {}

    while i <= len do
        local c = content:sub(i, i)

        if c == "\\" and content:sub(i+1, i+1) == "\"" then
            table.insert(buffer, "\"")
            i = i + 2

        elseif c == "\"" then
            if in_text then
                table.insert(result, "\\text{" .. table.concat(buffer) .. "}\\ ")
                buffer = {}
            else
                if #buffer > 0 then
                    table.insert(result, escape_spaces(table.concat(buffer), false))
                    buffer = {}
                end
            end
            in_text = not in_text
            i = i + 1

        else
            table.insert(buffer, c)
            i = i + 1
        end
    end

    if #buffer > 0 then
        local part = escape_spaces(table.concat(buffer), false)
        table.insert(result, part)
    end

    return table.concat(result)
end

function M.interprete(line)
    local trimmed = trim(line)
    if trimmed == "$$" then
        active = not active
        return ""
    end

    if not active then
        return line
    end

    local content = expand_macros(trimmed)

    if content:sub(1,1) == ">" then
        local rest = content:sub(2):gsub("^%s+", "")
        rest = process_math_line(rest)
        return "$$" .. rest .. "$$"
    else
        content = process_math_line(content)
        return "\\(" .. content .. "\\)<br>"
    end
end

return M


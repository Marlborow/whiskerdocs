local M = {}

function M.interprete(line)
    local level, content = line:match("^(#+)%s*(.-)%s*$")
    if level and #level >= 1 and #level <= 6 then
        return "<h" .. #level .. ">" .. content .. "</h" .. #level .. ">"
    end
    return line;
end

return M



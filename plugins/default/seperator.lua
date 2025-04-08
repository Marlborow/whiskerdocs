local M = {}

function M.interprete(line)
    if line:match("^%s*(.-)%s*$") == "---" then
        return "<hr>"
    end
    return line
end

return M


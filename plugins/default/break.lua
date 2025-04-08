local M = {}

function M.interprete(line)
    return line:gsub("::", "<br>")
end

return M



local M = {}
function M.run(line, plugins)
    local result = line

    for _,loaded in ipairs(plugins) do
        if loaded.interprete then
            result = loaded.interprete(result)
        end
    end

    return result .. "\n"
end

return M;

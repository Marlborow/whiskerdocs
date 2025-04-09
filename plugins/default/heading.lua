local M = {}

function M.interprete(line)
	local level, content = line:match("^(#+)%s*(.-)%s*$")
	if level and #level >= 1 and #level <= 6 then
		local id = content:lower():gsub("[^%w]+", "-"):gsub("^-+", ""):gsub("-+$", "")
		return "<h" .. #level .. ' id="' .. id .. '">' .. content .. "</h" .. #level .. ">"
	end
	return line
end

return M



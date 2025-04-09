local M = {}

function M.interprete(line)
	local level, rest = line:match("^(#+)%s*(.-)%s*$")
	if not level or #level < 1 or #level > 4 then
		return line
	end

	local content, flags = rest:match("^(.-)%s*|%s*(.-)%s*$")
	content = content or rest

	local id = content:lower():gsub("[^%w]+", "-"):gsub("^-+", ""):gsub("-+$", "")

	local class_attr = ""
	if flags then
		flags = flags:lower()
		if flags:find("c") then
			class_attr = ' class="center"'
		elseif flags:find("l") then
			class_attr = ' class="left"'
		elseif flags:find("r") then
			class_attr = ' class="right"'
		end
	end

	return "<h" .. #level .. ' id="' .. id .. '"' .. class_attr .. ">" .. content .. "</h" .. #level .. ">"
end

return M

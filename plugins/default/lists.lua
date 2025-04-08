local M = {}
local buffer = {}

local function getIndentLevel(line)
	local prefix = line:match("^(%s*>*)%s*%-")
	if not prefix then return 1 end
	local _, count = prefix:gsub(">", "")
	return count + 1
end

local function flushList()
	local html = ""
	local level = 0
	for i, line in ipairs(buffer) do
		local text = line:match("^%s*>*%s*%-%s+(.+)$")
		local newLevel = getIndentLevel(line)

		if newLevel > level then
			for _ = level + 1, newLevel do
				html = html .. "<ul>"
			end
		elseif newLevel < level then
			for _ = level, newLevel + 1, -1 do
				html = html .. "</li></ul>"
			end
			html = html .. "</li>"
		else
			if i > 1 then html = html .. "</li>" end
		end

		html = html .. "<li>" .. text
		level = newLevel
	end
	for _ = level, 1, -1 do
		html = html .. "</li></ul>"
	end
	buffer = {}
	return html
end

function M.interprete(line)
	if line:match("^%s*>*%s*%- %S") then
		buffer[#buffer + 1] = line
		return ""
	end
	if #buffer > 0 then
		local html = flushList() .. "\n" .. line
		return html
	end
	return line
end

return M


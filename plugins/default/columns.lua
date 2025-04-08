
local M = {}

local active = false
local columns = {}
local current = nil

function M.interprete(line)
	local trimmed = line:match("^%s*(.-)%s*$")

	if trimmed:match("^>|+$") then
		active = true
		columns = {}
		current = {}
		return ""
	elseif trimmed == "|>" and active then
		columns[#columns+1] = table.concat(current, "\n")
		current = {}
		return ""
	elseif trimmed == "<||" and active then
		columns[#columns+1] = table.concat(current, "\n")

		local html = { '<div class="columns">' }
		for _, col in ipairs(columns) do
			html[#html+1] = '<div class="column">' .. col .. '</div>'
		end
		html[#html+1] = '</div>'

		active = false
		columns = {}
		current = nil
		return table.concat(html, "\n")
	elseif active then
		current[#current+1] = line
		return ""
	end

	return line
end

return M

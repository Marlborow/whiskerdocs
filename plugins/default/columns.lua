local M = {}

function M.interprete(line)
	local trimmed = line:match("^%s*(.-)%s*$")

	if trimmed == ">|" then
		return '<div class="columns">\n<div class="column">\n'
	elseif trimmed == "|>" then
		return '</div>\n<div class="column">\n'
	elseif trimmed == "<|" then
		return '</div>\n</div>\n'
	end

	return line
end

return M


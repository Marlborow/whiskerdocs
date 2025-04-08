local M = {}

function M.interprete(line)
	line = line:gsub("%[(.-)%]%((.-)%)", function(text, url)
		return '<a href="' .. url .. '">' .. text .. '</a>'
	end)

	return line
end

return M

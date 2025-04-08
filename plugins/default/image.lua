
local M = {}

function M.interprete(line)
	line = line:gsub("!%[(.-)%]%((.-)%)", function(altRaw, src)
		local alt, opt = altRaw:match("^(.-)|%s*(.+)$")
		if not alt then alt = altRaw end
		local style = {}

		if opt then
			for token in opt:gmatch("%S+") do
				local k, v = token:match("^(%a):(%d+)$")
				if k == "w" then
					style[#style+1] = "width:" .. v .. "px"
				elseif k == "h" then
					style[#style+1] = "height:" .. v .. "px"
				end
				if token == "l" then
					style[#style+1] = "float:left"
				elseif token == "r" then
					style[#style+1] = "float:right"
				elseif token == "c" then
					style[#style+1] = "display:block;margin:0 auto"
				elseif token == "abs" then
					style[#style+1] = "position:absolute"
				end
			end
		end

		local styleStr = #style > 0 and ' style="' .. table.concat(style, ";") .. '"' or ""
		return '<img src="' .. src .. '" alt="' .. alt .. '"' .. styleStr .. '>'
	end)

	return line
end

return M

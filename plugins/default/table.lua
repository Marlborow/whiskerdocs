local M = {}
local active = false
local rows = {}
local function parseCells(row, tag)
	if not row then return "" end
	local cells = {}
	for cell in row:gmatch("|([^|]+)") do
		cells[#cells+1] = "<" .. tag .. ">" .. cell:match("^%s*(.-)%s*$") .. "</" .. tag .. ">"
	end
	return table.concat(cells, "")
end

function M.interprete(line)
	local t = line:match("^%s*(.-)%s*$")
	if t:sub(1, 1) == "|" and t:sub(-1) == "|" then
		active = true
		rows[#rows+1] = t
		return ""
	end
	if active then
		local html = '<table class="styled-table">'
		local hdr = table.remove(rows, 1)
		html = html .. "<thead><tr>" .. parseCells(hdr, "th") .. "</tr></thead><tbody>"
		for _, r in ipairs(rows) do
			if not r:match("^|%s*%-") then
				html = html .. "<tr>" .. parseCells(r, "td") .. "</tr>"
			end
		end
		html = html .. "</tbody></table>"
		active = false
		rows = {}
		return html .. "\n" .. line
	end
	return line
end

return M


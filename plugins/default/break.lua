local M = {}

function M.interprete(line)
	-- Page break: ':::'
	if line:match("^%s*:::%s*$") then
		return '<div class="page-break"></div>'
	end

	-- Normal line break: '::'
	return line:gsub("::", "<br>")
end

return M

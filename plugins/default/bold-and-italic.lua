local M = {}

local triggers = {
  ["***"] = { "<b><i>", "</i></b>" },
  ["**"]  = { "<b>",    "</b>"     },
  ["*"]   = { "<i>",    "</i>"     },
}

function M.interprete(line)
  local words = {}
  for word in line:gmatch("%S+") do
    table.insert(words, word)
  end

  local output = {}
  local state = { ["***"] = 0, ["**"] = 0, ["*"] = 0 }

  for _, word in ipairs(words) do
    local handledWholeWord = false

    for trigger, tags in pairs(triggers) do
      if word == trigger then
        local count = state[trigger]
        table.insert(output, (count % 2 == 0) and tags[1] or tags[2])
        state[trigger] = count + 1
        handledWholeWord = true
        break
      end
    end

    if not handledWholeWord then
      local i = 1
      while i <= #word do
        local matched = false
        for _, trig in ipairs({ "***", "**", "*" }) do
          local tags = triggers[trig]
          local tlen = #trig
          if word:sub(i, i + tlen - 1) == trig then
            local count = state[trig]
            table.insert(output, (count % 2 == 0) and tags[1] or tags[2])
            state[trig] = count + 1
            i = i + tlen
            matched = true
            break
          end
        end

        if not matched then
          output[#output + 1] = word:sub(i, i)
          i = i + 1
        end
      end
    end

    output[#output + 1] = " "
  end

  for trig, count in pairs(state) do
    if count % 2 ~= 0 then
      output[#output + 1] = triggers[trig][2]  -- the closing tag
    end
  end
  return table.concat(output):gsub("%s+$", "")
end

return M


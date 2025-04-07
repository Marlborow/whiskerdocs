-- strlen
function strlen(s)
  return #s
end

-- strcmp
function strcmp(a, b)
  if a == b then return 0 end
  return (a > b) and 1 or -1
end

-- strncmp
function strncmp(a, b, n)
  local sa = a:sub(1, n)
  local sb = b:sub(1, n)
  return strcmp(sa, sb)
end

-- strcpy (returns copy, since strings are immutable in Lua)
function strcpy(dest, src)
  return src
end

-- strncpy
function strncpy(dest, src, n)
  local sub = src:sub(1, n)
  if #sub < n then
    sub = sub .. string.rep('\0', n - #sub)
  end
  return sub
end

-- strcat
function strcat(dest, src)
  return dest .. src
end

-- strncat
function strncat(dest, src, n)
  return dest .. src:sub(1, n)
end

-- strchr
function strchr(s, c)
  local i = s:find(c, 1, true)
  if i then return s:sub(i) end
  return nil
end

-- strrchr
function strrchr(s, c)
  if not s or not c then return nil end
  local last = nil
  for i = 1, #s do
    if s:sub(i, i) == c then
      last = i
    end
  end
  return last and s:sub(last) or nil
end


-- strstr
function strstr(haystack, needle)
  local i = haystack:find(needle, 1, true)
  if i then return haystack:sub(i) end
  return nil
end

-- strspn
function strspn(s, accept)
  local count = 0
  for i = 1, #s do
    if not accept:find(s:sub(i, i), 1, true) then break end
    count = count + 1
  end
  return count
end

-- strcspn
function strcspn(s, reject)
  local count = 0
  for i = 1, #s do
    if reject:find(s:sub(i, i), 1, true) then break end
    count = count + 1
  end
  return count
end

-- strtok (uses closure to mimic static internal state)
do
  local state = nil
  function strtok(s, delim)
    if s ~= nil then state = s end
    if not state then return nil end
    local start = 1
    while start <= #state and delim:find(state:sub(start, start), 1, true) do
      start = start + 1
    end
    if start > #state then state = nil return nil end
    local stop = start
    while stop <= #state and not delim:find(state:sub(stop, stop), 1, true) do
      stop = stop + 1
    end
    local token = state:sub(start, stop - 1)
    state = (stop <= #state) and state:sub(stop + 1) or nil
    return token
  end
end

-- memset (returns string of repeated character)
function memset(c, n)
  return string.rep(c, n)
end

-- memcpy (copy n bytes)
function memcpy(dest, src, n)
  return src:sub(1, n)
end

-- memcmp
function memcmp(a, b, n)
  return strcmp(a:sub(1, n), b:sub(1, n))
end

-- memchr
function memchr(buf, c, n)
  local sub = buf:sub(1, n)
  local i = sub:find(c, 1, true)
  if i then return sub:sub(i) end
  return nil
end


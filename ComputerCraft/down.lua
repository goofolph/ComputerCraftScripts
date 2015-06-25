-- Downloads any file from http

local args = {...}

-- check for url
if not args[1] then
  return false
end

local url = args[1]

-- check for filename
if not args[2] then
  return false
end
local filename = args[2]

download = http.get(url)
if download then
  file = io.open(filename);
  file:write(download.readAll())
  file:close()
  return true
else
  return false
end

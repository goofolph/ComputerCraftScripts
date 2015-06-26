-- Downloads any file from http

local args = {...}

-- check for url
if not args[1] then
  print("No url given")
  return false
end

local url = args[1]

-- check for filename
if not args[2] then
  print("No filename given")
  return false
end
local filename = args[2]

download = http.get(url)
if download then
  file = fs.open(filename, "w");
  if file then
    file:write(download.readAll())
    file:close()
    print("download successful")
    return true
  else
    print("error opening file")
    return false
  end
else
  print("error downloading file")
  return false
end

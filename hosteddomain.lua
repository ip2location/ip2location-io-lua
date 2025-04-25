local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("JSON")
local urlencode = require("urlencode")

-- for debugging purposes
local function printme(stuff)
  local inspect = require("inspect")
  print(inspect(stuff))
end

hosteddomain = {
  configuration = nil,
  base_url = "https://domains.ip2whois.com/domains",
  source = "sdk-lua-iplio",
  format = "json",
  error_message = "HostedDomain lookup error.",
}
hosteddomain.__index = hosteddomain

hosteddomainresult = {
  ip = "",
  total_domains = 0,
  page = 0,
  per_page = 0,
  total_pages = 0,
  domains = {},
}
hosteddomainresult.__index = hosteddomainresult

-- initialize the component with the configuration
function hosteddomain:open(configuration)
  local x = {}
  setmetatable(x, hosteddomain) -- make hosteddomain handle lookup
  x.configuration = configuration
  return x
end

-- main query
function hosteddomain:lookup(ipaddress, page)
  local t = {}

  local full_url = self.base_url
  .. "?format="
  .. self.format
  .. "&source="
  .. self.source
  .. "&source_version="
  .. self.configuration.version
  .. "&key="
  .. urlencode.encode_url(self.configuration.api_key)
  .. "&ip="
  .. urlencode.encode_url(ipaddress)

  if page ~= nil then
    full_url = full_url .. "&page=" .. page
  end

  local status, code, headers = http.request({
      method = "GET",
      url = full_url,
      sink = ltn12.sink.table(t),
    })
  local jsonstr = table.concat(t)

  if code == 200 then
    local result = json:decode(jsonstr)
    setmetatable(result, hosteddomainresult)
    return result
  elseif code == 400 or code == 401 then
    if jsonstr:find("error_message") then
      local result = json:decode(jsonstr)
      error(result.error.error_message)
    end
  end

  error(self.error_message)
end

return hosteddomain

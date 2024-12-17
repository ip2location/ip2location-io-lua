local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("JSON")
local urlencode = require("urlencode")

-- for debugging purposes
local function printme(stuff)
  local inspect = require("inspect")
  print(inspect(stuff))
end

ipgeolocation = {
  configuration = nil,
  base_url = "https://api.ip2location.io/",
  source = "sdk-lua-iplio",
  format = "json",
  error_message = "IPGeolocation lookup error.",
}
ipgeolocation.__index = ipgeolocation

ipgeolocationresult = {
  ip = "",
  country_code = "",
  country_name = "",
  region_name = "",
  city_name = "",
  latitude = 0,
  longitude = 0,
  zip_code = "",
  time_zone = "",
  asn = "",
  as = "",
  isp = "",
  domain = "",
  net_speed = "",
  idd_code = "",
  area_code = "",
  weather_station_code = "",
  weather_station_name = "",
  mcc = "",
  mnc = "",
  mobile_brand = "",
  elevation = 0,
  usage_type = "",
  address_type = "",
  category = "",
  category_name = "",
  continent = nil,
  district = "",
  country = nil,
  region = nil,
  city = nil,
  time_zone_info = nil,
  geotargeting = nil,
  ads_category = "",
  ads_category_name = "",
  is_proxy = false,
  fraud_score = 0,
  proxy = nil,
}
ipgeolocationresult.__index = ipgeolocationresult

-- initialize the component with the configuration
function ipgeolocation:open(configuration)
  local x = {}
  setmetatable(x, ipgeolocation) -- make ipgeolocation handle lookup
  x.configuration = configuration
  return x
end

-- main query
function ipgeolocation:lookup(ipaddress, lang)
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

  if lang ~= nil then
    full_url = full_url .. "&lang=" .. urlencode.encode_url(lang) -- lang param only supported in Plus and Security plans
  end

  local status, code, headers = http.request({
      method = "GET",
      url = full_url,
      sink = ltn12.sink.table(t),
    })
  local jsonstr = table.concat(t)

  if code == 200 then
    local result = json:decode(jsonstr)
    setmetatable(result, ipgeolocationresult)
    return result
  elseif code == 400 or code == 401 then
    if jsonstr:find("error_message") then
      local result = json:decode(jsonstr)
      error(result.error.error_message)
    end
  end

  error(self.error_message)
end

return ipgeolocation

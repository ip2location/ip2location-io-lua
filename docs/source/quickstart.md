# Quickstart

## Dependencies

This module requires API key to function. You may sign up for a free API key at <https://www.ip2location.io/pricing>.

## Installation

To install this library using luarocks:

```bash

luarocks install ip2locationio

```

## Sample Codes

### Lookup IP Address Geolocation Data

You can make a geolocation data lookup for an IP address as below:

``` lua
local configuration = require("configuration")
local ipgeolocation = require("ipgeolocation")

local apikey = "YOUR_API_KEY"

local lang = "fr" -- leave blank if no need

configuration.api_key = apikey
local ip = "8.8.8.8"
local ipl = ipgeolocation:open(configuration)

local result = ipl:lookup(ip, lang) -- lang param only supported in Plus and Security plans so omit param if no need

-- standard results
print("version: " .. configuration.version)
print("ip: " .. result.ip)
print("country_code: " .. result.country_code)
print("country_name: " .. result.country_name)
print("region_name: " .. result.region_name)
print("city_name: " .. result.city_name)
print("latitude: " .. result.latitude)
print("longitude: " .. result.longitude)
print("zip_code: " .. result.zip_code)
print("time_zone: " .. result.time_zone)
print("asn: " .. result.asn)
print("as: " .. result.as)
print("isp: " .. result.isp)
print("domain: " .. result.domain)
print("net_speed: " .. result.net_speed)
print("idd_code: " .. result.idd_code)
print("area_code: " .. result.area_code)
print("weather_station_code: " .. result.weather_station_code)
print("weather_station_name: " .. result.weather_station_name)
print("mcc: " .. result.mcc)
print("mnc: " .. result.mnc)
print("mobile_brand: " .. result.mobile_brand)
print("elevation: " .. result.elevation)
print("usage_type: " .. result.usage_type)
print("address_type: " .. result.address_type)
print("category: " .. result.category)
print("category_name: " .. result.category_name)
print("district: " .. result.district)
print("ads_category: " .. result.ads_category)
print("ads_category_name: " .. result.ads_category_name)
print("is_proxy: " .. tostring(result.is_proxy))
print("fraud_score: " .. result.fraud_score)

-- continent addon
if result["continent"] ~= nil then
  print("continent => name: " .. result.continent.name)
  print("continent => code: " .. result.continent.code)
  print("continent => hemisphere: " .. table.concat(result.continent.hemisphere, ","))
  if lang ~= "" and result.continent.translation.lang ~= nil then
    print("continent => translation => lang: " .. result.continent.translation.lang)
    print("continent => translation => value: " .. result.continent.translation.value)
  end
end

-- country addon
if result["country"] ~= nil then
  print("country => name: " .. result.country.name)
  print("country => alpha3_code: " .. result.country.alpha3_code)
  print("country => numeric_code: " .. result.country.numeric_code)
  print("country => demonym: " .. result.country.demonym)
  print("country => flag: " .. result.country.flag)
  print("country => capital: " .. result.country.capital)
  print("country => total_area: " .. result.country.total_area)
  print("country => population: " .. result.country.population)
  print("country => tld: " .. result.country.tld)

  print("country => currency => code: " .. result.country.currency.code)
  print("country => currency => name: " .. result.country.currency.name)
  print("country => currency => symbol: " .. result.country.currency.symbol)

  print("country => language => code: " .. result.country.language.code)
  print("country => language => name: " .. result.country.language.name)

  if lang ~= "" and result.country.translation.lang ~= nil then
    print("country => translation => lang: " .. result.country.translation.lang)
    print("country => translation => value: " .. result.country.translation.value)
  end
end

-- region addon
if result["region"] ~= nil then
  print("region => name: " .. result.region.name)
  print("region => code: " .. result.region.code)
  if lang ~= "" and result.region.translation.lang ~= nil then
    print("region => translation => lang: " .. result.region.translation.lang)
    print("region => translation => value: " .. result.region.translation.value)
  end
end

-- city addon
if result["city"] ~= nil then
  print("city => name: " .. result.city.name)
  if lang ~= "" and result.city.translation.lang ~= nil then
    print("city => translations => lang: " .. result.city.translation.lang)
    print("city => translations => value: " .. result.city.translation.value)
  end
end

-- time_zone_info addon
if result["time_zone_info"] ~= nil then
  print("time_zone_info => olson: " .. result.time_zone_info.olson)
  print("time_zone_info => current_time: " .. result.time_zone_info.current_time)
  print("time_zone_info => gmt_offset: " .. result.time_zone_info.gmt_offset)
  print("time_zone_info => is_dst: " .. tostring(result.time_zone_info.is_dst))
  print("time_zone_info => abbreviation: " .. tostring(result.time_zone_info.abbreviation))
  print("time_zone_info => dst_start_date: " .. tostring(result.time_zone_info.dst_start_date))
  print("time_zone_info => dst_end_date: " .. tostring(result.time_zone_info.dst_end_date))
  print("time_zone_info => sunrise: " .. result.time_zone_info.sunrise)
  print("time_zone_info => sunset: " .. result.time_zone_info.sunset)
end

-- geotargeting addon
if result["geotargeting"] ~= nil then
  print("geotargeting => metro: " .. result.geotargeting.metro)
end

-- proxy addon
if result["proxy"] ~= nil then
  print("proxy => last_seen: " .. result.proxy.last_seen)
  print("proxy => proxy_type: " .. result.proxy.proxy_type)
  print("proxy => threat: " .. result.proxy.threat)
  print("proxy => provider: " .. result.proxy.provider)
  print("proxy => is_vpn: " .. tostring(result.proxy.is_vpn))
  print("proxy => is_tor: " .. tostring(result.proxy.is_tor))
  print("proxy => is_data_center: " .. tostring(result.proxy.is_data_center))
  print("proxy => is_public_proxy: " .. tostring(result.proxy.is_public_proxy))
  print("proxy => is_web_proxy: " .. tostring(result.proxy.is_web_proxy))
  print("proxy => is_web_crawler: " .. tostring(result.proxy.is_web_crawler))
  print("proxy => is_residential_proxy: " .. tostring(result.proxy.is_residential_proxy))
  print("proxy => is_consumer_privacy_network: " .. tostring(result.proxy.is_consumer_privacy_network))
  print("proxy => is_enterprise_private_network: " .. tostring(result.proxy.is_enterprise_private_network))
  print("proxy => is_spammer: " .. tostring(result.proxy.is_spammer))
  print("proxy => is_scanner: " .. tostring(result.proxy.is_scanner))
  print("proxy => is_botnet: " .. tostring(result.proxy.is_botnet))
  print("proxy => is_bogon: " .. tostring(result.proxy.is_bogon))
end
```

### Lookup Domain Information

You can lookup domain information as below:

```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")

local apikey = "YOUR_API_KEY"

configuration.api_key = apikey
local domain = "locaproxy.com"
local whois = domainwhois:open(configuration)

local result = whois:lookup(domain)

print("version: " .. configuration.version)
print("domain: " .. result.domain)
print("domain_id: " .. result.domain_id)
print("status: " .. result.status)
print("create_date: " .. result.create_date)
print("update_date: " .. result.update_date)
print("expire_date: " .. result.expire_date)
print("domain_age: " .. result.domain_age)
print("whois_server: " .. result.whois_server)

print("registrar => iana_id: " .. result.registrar.iana_id)
print("registrar => name: " .. result.registrar.name)
print("registrar => url: " .. result.registrar.url)

print("registrant => name: " .. result.registrant.name)
print("registrant => organization: " .. result.registrant.organization)
print("registrant => street_address: " .. result.registrant.street_address)
print("registrant => city: " .. result.registrant.city)
print("registrant => region: " .. result.registrant.region)
print("registrant => zip_code: " .. result.registrant.zip_code)
print("registrant => country: " .. result.registrant.country)
print("registrant => phone: " .. result.registrant.phone)
print("registrant => fax: " .. result.registrant.fax)
print("registrant => email: " .. result.registrant.email)

print("admin => name: " .. result.admin.name)
print("admin => organization: " .. result.admin.organization)
print("admin => street_address: " .. result.admin.street_address)
print("admin => city: " .. result.admin.city)
print("admin => region: " .. result.admin.region)
print("admin => zip_code: " .. result.admin.zip_code)
print("admin => country: " .. result.admin.country)
print("admin => phone: " .. result.admin.phone)
print("admin => fax: " .. result.admin.fax)
print("admin => email: " .. result.admin.email)

print("tech => name: " .. result.tech.name)
print("tech => organization: " .. result.tech.organization)
print("tech => street_address: " .. result.tech.street_address)
print("tech => city: " .. result.tech.city)
print("tech => region: " .. result.tech.region)
print("tech => zip_code: " .. result.tech.zip_code)
print("tech => country: " .. result.tech.country)
print("tech => phone: " .. result.tech.phone)
print("tech => fax: " .. result.tech.fax)
print("tech => email: " .. result.tech.email)

print("billing => name: " .. result.billing.name)
print("billing => organization: " .. result.billing.organization)
print("billing => street_address: " .. result.billing.street_address)
print("billing => city: " .. result.billing.city)
print("billing => region: " .. result.billing.region)
print("billing => zip_code: " .. result.billing.zip_code)
print("billing => country: " .. result.billing.country)
print("billing => phone: " .. result.billing.phone)
print("billing => fax: " .. result.billing.fax)
print("billing => email: " .. result.billing.email)

print("nameservers: " .. table.concat(result.nameservers, ","))
```

### Convert Normal Text to Punycode

You can convert an international domain name to Punycode as below:

```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getpunycode("täst.de"))
```

### Convert Punycode to Normal Text

You can convert a Punycode to international domain name as below:

```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getnormaltext("xn--tst-qla.de"))
```

### Get Domain Name

You can extract the domain name from an url as below:

```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getdomainname("https://www.example.com/exe"))
```

### Get Domain Extension

You can extract the domain extension from a domain name or url as below:

```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getdomainextension("example.com"))
```

### Lookup IP Address Hosted Domains Data

You can lookup hosted domains information as below:

```lua
local configuration = require("configuration")
local hosteddomain = require("hosteddomain")

local apikey = "YOUR_API_KEY"

configuration.api_key = apikey
local ip = "8.8.8.8"
local hd = hosteddomain:open(configuration)

local result = hd:lookup(ip)

print("version: " .. configuration.version)
print("ip: " .. result.ip)
print("total_domains: " .. result.total_domains)
print("page: " .. result.page)
print("per_page: " .. result.per_page)
print("total_pages: " .. result.total_pages)
print("domains: " .. table.concat(result.domains, ","))
```

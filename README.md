IP2Location.io Lua SDK
======================
This Lua package enables user to query for an enriched data set, such as country, region, district, city, latitude & longitude, ZIP code, time zone, ASN, ISP, domain, net speed, IDD code, area code, weather station data, MNC, MCC, mobile brand, elevation, usage type, address type, advertisement category and proxy data with an IP address. It supports both IPv4 and IPv6 address lookup.

In addition, this module provides WHOIS lookup api that helps users to obtain domain information, WHOIS record, by using a domain name. The WHOIS API returns a comprehensive WHOIS data such as creation date, updated date, expiration date, domain age, the contact information of the registrant, mailing address, phone number, email address, nameservers the domain is using and much more.

This module requires API key to function. You may sign up for a free API key at https://www.ip2location.io/pricing.


Installation
============
```bash

luarocks install ip2locationio

```


Usage Example
============
### Lookup IP Address Geolocation Data
```lua
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
  print("proxy => is_spammer: " .. tostring(result.proxy.is_spammer))
  print("proxy => is_scanner: " .. tostring(result.proxy.is_scanner))
  print("proxy => is_botnet: " .. tostring(result.proxy.is_botnet))
end
```

### Lookup Domain Information
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
```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getpunycode("täst.de"))
```

### Convert Punycode to Normal Text
```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getnormaltext("xn--tst-qla.de"))
```

### Get Domain Name
```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getdomainname("https://www.example.com/exe"))
```

### Get Domain Extension
```lua
local configuration = require("configuration")
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getdomainextension("example.com"))
```


Response Parameter
============
### IP Geolocation Lookup function
| Parameter | Type | Description |
|---|---|---|
|ip|string|IP address.|
|country_code|string|Two-character country code based on ISO 3166.|
|country_name|string|Country name based on ISO 3166.|
|region_name|string|Region or state name.|
|city_name|string|City name.|
|latitude|double|City latitude. Defaults to capital city latitude if city is unknown.|
|longitude|double|City longitude. Defaults to capital city longitude if city is unknown.|
|zip_code|string|ZIP/Postal code.|
|time_zone|string|UTC time zone (with DST supported).|
|asn|string|Autonomous system number (ASN).|
|as|string|Autonomous system (AS) name.|
|isp|string|Internet Service Provider or company's name.|
|domain|string|Internet domain name associated with IP address range.|
|net_speed|string|Internet connection type. DIAL = dial-up, DSL = broadband/cable/fiber/mobile, COMP = company/T1|
|idd_code|string|The IDD prefix to call the city from another country.|
|area_code|string|A varying length number assigned to geographic areas for calls between cities.|
|weather_station_code|string|The special code to identify the nearest weather observation station.|
|weather_station_name|string|The name of the nearest weather observation station.|
|mcc|string|Mobile Country Codes (MCC) as defined in ITU E.212 for use in identifying mobile stations in wireless telephone networks, particularly GSM and UMTS networks.|
|mnc|string|Mobile Network Code (MNC) is used in combination with a Mobile Country Code (MCC) to uniquely identify a mobile phone operator or carrier.|
|mobile_brand|string|Commercial brand associated with the mobile carrier.|
|elevation|integer|Average height of city above sea level in meters (m).|
|usage_type|string|Usage type classification of ISP or company.|
|address_type|string|IP address types as defined in Internet Protocol version 4 (IPv4) and Internet Protocol version 6 (IPv6).|
|continent.name|string|Continent name.|
|continent.code|string|Two-character continent code.|
|continent.hemisphere|array|The hemisphere of where the country located. The data in array format with first item indicates (north/south) hemisphere and second item indicates (east/west) hemisphere information.|
|continent.translation|object|Translation data based on the given lang code.|
|district|string|District or county name.|
|country.name|string|Country name based on ISO 3166.|
|country.alpha3_code|string|Three-character country code based on ISO 3166.|
|country.numeric_code|string|Three-character country numeric code based on ISO 3166.|
|country.demonym|string|Native of the country.|
|country.flag|string|URL of the country flag image.|
|country.capital|string|Capital of the country.|
|country.total_area|integer|Total area in km2.|
|country.population|integer|Population of the country.|
|country.currency|object|Currency of the country.|
|country.language|object|Language of the country.|
|country.tld|string|Country-Code Top-Level Domain.|
|country.translation|object|Translation data based on the given lang code.|
|region.name|string|Region or state name.|
|region.code|string|ISO3166-2 code.|
|region.translation|object|Translation data based on the given lang code.|
|city.name|string| City name.|
|city.translation|object|Translation data based on the given lang code.|
|time_zone_info.olson|string|Time zone in Olson format.|
|time_zone_info.current_time|string|Current time in ISO 8601 format.|
|time_zone_info.gmt_offset|integer|GMT offset value in seconds.|
|time_zone_info.is_dst|boolean|Indicate if the time zone value is in DST.|
|time_zone_info.sunrise|string|Time of sunrise. (hh:mm format in local time, i.e, 07:47)|
|time_zone_info.sunset|string|Time of sunset. (hh:mm format in local time, i.e 19:50)|
|geotargeting.metro|string|Metro code based on zip/postal code.|
|ads_category|string|The domain category code based on IAB Tech Lab Content Taxonomy.|
|ads_category_name|string|The domain category based on IAB Tech Lab Content Taxonomy. These categories are comprised of Tier-1 and Tier-2 (if available) level categories widely used in services like advertising, Internet security and filtering appliances.|
|is_proxy|boolean|Whether is a proxy or not.|
|proxy.last_seen|integer|Proxy last seen in days.|
|proxy.proxy_type|string|Type of proxy.|
|proxy.threat|string|Security threat reported.|
|proxy.provider|string|Name of VPN provider if available.|
|proxy.is_vpn|boolean|Anonymizing VPN services.|
|proxy.is_tor|boolean|Tor Exit Nodes.|
|proxy.is_data_center|boolean|Hosting Provider, Data Center or Content Delivery Network.|
|proxy.is_public_proxy|boolean|Public Proxies.|
|proxy.is_web_proxy|boolean|Web Proxies.|
|proxy.is_web_crawler|boolean|Search Engine Robots.|
|proxy.is_residential_proxy|boolean|Residential proxies.|
|proxy.is_spammer|boolean|Email and forum spammers.|
|proxy.is_scanner|boolean|Network security scanners.|
|proxy.is_botnet|boolean|Malware infected devices.|

```json
{
  "ip": "8.8.8.8",
  "country_code": "US",
  "country_name": "United States of America",
  "region_name": "California",
  "city_name": "Mountain View",
  "latitude": 37.405992,
  "longitude": -122.078515,
  "zip_code": "94043",
  "time_zone": "-07:00",
  "asn": "15169",
  "as": "Google LLC",
  "isp": "Google LLC",
  "domain": "google.com",
  "net_speed": "T1",
  "idd_code": "1",
  "area_code": "650",
  "weather_station_code": "USCA0746",
  "weather_station_name": "Mountain View",
  "mcc": "-",
  "mnc": "-",
  "mobile_brand": "-",
  "elevation": 32,
  "usage_type": "DCH",
  "address_type": "Anycast",
  "continent": {
    "name": "North America",
    "code": "NA",
    "hemisphere": [
      "north",
      "west"
    ],
    "translation": {
      "lang": "es",
      "value": "Norteamérica"
    }
  },
  "district": "Santa Clara County",
  "country": {
    "name": "United States of America",
    "alpha3_code": "USA",
    "numeric_code": 840,
    "demonym": "Americans",
    "flag": "https://cdn.ip2location.io/assets/img/flags/us.png",
    "capital": "Washington, D.C.",
    "total_area": 9826675,
    "population": 331002651,
    "currency": {
      "code": "USD",
      "name": "United States Dollar",
      "symbol": "$"
    },
    "language": {
      "code": "EN",
      "name": "English"
    },
    "tld": "us",
    "translation": {
      "lang": "es",
      "value": "Estados Unidos de América (los)"
    }
  },
  "region": {
    "name": "California",
    "code": "US-CA",
    "translation": {
      "lang": "es",
      "value": "California"
    }
  },
  "city": {
    "name": "Mountain View",
    "translation": {
      "lang": null,
      "value": null
    }
  },
  "time_zone_info": {
    "olson": "America/Los_Angeles",
    "current_time": "2023-09-03T18:21:13-07:00",
    "gmt_offset": -25200,
    "is_dst": true,
    "sunrise": "06:41",
    "sunset": "19:33"
  },
  "geotargeting": {
    "metro": "807"
  },
  "ads_category": "IAB19-11",
  "ads_category_name": "Data Centers",
  "is_proxy": false,
  "proxy": {
    "last_seen": 3,
    "proxy_type": "DCH",
    "threat": "-",
    "provider": "-",
    "is_vpn": false,
    "is_tor": false,
    "is_data_center": true,
    "is_public_proxy": false,
    "is_web_proxy": false,
    "is_web_crawler": false,
    "is_residential_proxy": false,
    "is_spammer": false,
    "is_scanner": false,
    "is_botnet": false
  }
}
```

### Domain WHOIS Lookup function
| Parameter | Type | Description |
|---|---|---|
|domain|string|Domain name.|
|domain_id|string|Domain name ID.|
|status|string|Domain name status.|
|create_date|string|Domain name creation date.|
|update_date|string|Domain name updated date.|
|expire_date|string|Domain name expiration date.|
|domain_age|integer|Domain name age in day(s).|
|whois_server|string|WHOIS server name.|
|registrar.iana_id|string|Registrar IANA ID.|
|registrar.name|string|Registrar name.|
|registrar.url|string|Registrar URL.|
|registrant.name|string|Registrant name.|
|registrant.organization|string|Registrant organization.|
|registrant.street_address|string|Registrant street address.|
|registrant.city|string|Registrant city.|
|registrant.region|string|Registrant region.|
|registrant.zip_code|string|Registrant ZIP Code.|
|registrant.country|string|Registrant country.|
|registrant.phone|string|Registrant phone number.|
|registrant.fax|string|Registrant fax number.|
|registrant.email|string|Registrant email address.|
|admin.name|string|Admin name.|
|admin.organization|string|Admin organization.|
|admin.street_address|string|Admin street address.|
|admin.city|string|Admin city.|
|admin.region|string|Admin region.|
|admin.zip_code|string|Admin ZIP Code.|
|admin.country|string|Admin country.|
|admin.phone|string|Admin phone number.|
|admin.fax|string|Admin fax number.|
|admin.email|string|Admin email address.|
|tech.name|string|Tech name.|
|tech.organization|string|Tech organization.|
|tech.street_address|string|Tech street address.|
|tech.city|string|Tech city.|
|tech.region|string|Tech region.|
|tech.zip_code|string|Tech ZIP Code.|
|tech.country|string|Tech country.|
|tech.phone|string|Tech phone number.|
|tech.fax|string|Tech fax number.|
|tech.email|string|Tech email address.|
|billing.name|string|Billing name.|
|billing.organization|string|Billing organization.|
|billing.street_address|string|Billing street address.|
|billing.city|string|Billing city.|
|billing.region|string|Billing region.|
|billing.zip_code|string|Billing ZIP Code.|
|billing.country|string|Billing country.|
|billing.phone|string|Billing phone number.|
|billing.fax|string|Billing fax number.|
|billing.email|string|Billing email address.|
|nameservers|array|Name servers|

```json
{
    "domain": "locaproxy.com",
    "domain_id": "1710914405_DOMAIN_COM-VRSN",
    "status": "clientTransferProhibited https://icann.org/epp#clientTransferProhibited",
    "create_date": "2012-04-03T02:34:32Z",
    "update_date": "2021-12-03T02:54:57Z",
    "expire_date": "2024-04-03T02:34:32Z",
    "domain_age": 3863,
    "whois_server": "whois.godaddy.com",
    "registrar": {
        "iana_id": "146",
        "name": "GoDaddy.com, LLC",
        "url": "https://www.godaddy.com"
    },
    "registrant": {
        "name": "Registration Private",
        "organization": "Domains By Proxy, LLC",
        "street_address": "DomainsByProxy.com",
        "city": "Tempe",
        "region": "Arizona",
        "zip_code": "85284",
        "country": "US",
        "phone": "+1.4806242599",
        "fax": "+1.4806242598",
        "email": "Select Contact Domain Holder link at https://www.godaddy.com/whois/results.aspx?domain=LOCAPROXY.COM"
    },
    "admin": {
        "name": "Registration Private",
        "organization": "Domains By Proxy, LLC",
        "street_address": "DomainsByProxy.com",
        "city": "Tempe",
        "region": "Arizona",
        "zip_code": "85284",
        "country": "US",
        "phone": "+1.4806242599",
        "fax": "+1.4806242598",
        "email": "Select Contact Domain Holder link at https://www.godaddy.com/whois/results.aspx?domain=LOCAPROXY.COM"
    },
    "tech": {
        "name": "Registration Private",
        "organization": "Domains By Proxy, LLC",
        "street_address": "DomainsByProxy.com",
        "city": "Tempe",
        "region": "Arizona",
        "zip_code": "85284",
        "country": "US",
        "phone": "+1.4806242599",
        "fax": "+1.4806242598",
        "email": "Select Contact Domain Holder link at https://www.godaddy.com/whois/results.aspx?domain=LOCAPROXY.COM"
    },
    "billing": {
        "name": "",
        "organization": "",
        "street_address": "",
        "city": "",
        "region": "",
        "zip_code": "",
        "country": "",
        "phone": "",
        "fax": "",
        "email": ""
    },
    "nameservers": ["vera.ns.cloudflare.com", "walt.ns.cloudflare.com"]
}
```


LICENCE
=====================
See the LICENSE file.

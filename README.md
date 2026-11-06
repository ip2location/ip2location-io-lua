# IP2Location.io Lua SDK — IP Geolocation, Domain WHOIS & Hosted Domain Lookup
[![LuaRocks](https://img.shields.io/badge/LuaRocks-1.1.0--1-blue)](https://luarocks.org/modules/ip2location/ip2locationio)

**IP2Location.io Lua SDK** is a Lua library for retrieving **IPv4 and IPv6 geolocation, network and IP intelligence data** through the [IP2Location.io API](https://www.ip2location.io/). It also supports **domain WHOIS lookup** and **hosted domain lookup**. Use the SDK to integrate IP and domain information into Lua applications without manually constructing API requests.

**Quick links:** [Get an API key](https://www.ip2location.io/pricing) · [Developer documentation](https://ip2location-io-lua.readthedocs.io/en/latest/index.html) · [Lua quickstart and examples](https://ip2location-io-lua.readthedocs.io/en/latest/quickstart.html) · [GitHub repository](https://github.com/ip2location/ip2location-io-lua)

## Features

- **IPv4 and IPv6 geolocation:** Retrieve country, region, district, city, latitude, longitude, ZIP/postal code and time zone information.
- **Network and ASN information:** Access available ASN, AS name, ISP, associated domain, connection speed, usage type and other network attributes.
- **Time zone and localization data:** Access time zone details and, on eligible plans, request translated location names using a language parameter.
- **Proxy and security signals:** Inspect available proxy, VPN, Tor, data center, crawler and other threat-related indicators, along with a fraud score where supported.
- **Additional IP intelligence:** Access plan-dependent mobile carrier information (MCC/MNC), country metadata, elevation and advertising categories.
- **Domain WHOIS lookup:** Retrieve available registration dates, domain status, registrar, nameservers and contact information.
- **Internationalized domain and URL utilities:** Convert Unicode domain names to Punycode and back, extract a domain name from a URL and obtain its domain extension.
- **Hosted domains:** Retrieve domain names hosted on an IPv4 or IPv6 address, with optional pagination.

> **Plan availability:** Not all fields are included in every API plan, and some values may be unavailable for particular IP addresses or domains. Refer to the [pricing page](https://www.ip2location.io/pricing) and [Lua quickstart](https://ip2location-io-lua.readthedocs.io/en/latest/quickstart.html) for details.

## SDK modules

The Lua SDK provides four modules. Each service is initialized with `:open(configuration)` and queried using its documented methods.

| Module | Description |
| --- | --- |
| [`configuration`](https://github.com/ip2location/ip2location-io-lua/blob/main/configuration.lua) | Stores the API key and SDK version. |
| [`ipgeolocation`](https://github.com/ip2location/ip2location-io-lua/blob/main/ipgeolocation.lua) | Performs IPv4/IPv6 geolocation and available network/security data lookups with `:lookup(ip, lang)`. |
| [`domainwhois`](https://github.com/ip2location/ip2location-io-lua/blob/main/domainwhois.lua) | Performs WHOIS lookups and offers domain/Punycode helper methods. |
| [`hosteddomain`](https://github.com/ip2location/ip2location-io-lua/blob/main/hosteddomain.lua) | Retrieves hosted domains with `:lookup(ip, page)` and optional pagination. |

## API access and query limits

IP2Location.io provides keyless IP geolocation requests through its REST API and a Free plan with an API key:

| API service | Keyless (no API key) | Free plan (with API key) |
| --- | --- | --- |
| IP Geolocation API | **1,000 queries/day** | **50,000 queries/month** |
| Domain WHOIS API | — | **500 queries/month** |
| Hosted Domain API | — | **50 queries/month** |

- **Keyless access:** Limited geolocation queries can be made directly through the [REST API](https://www.ip2location.io/ip2location-documentation), with a daily reset at **00:00 UTC**. The Lua SDK requires an API key; keyless operation is not documented for this SDK.
- **Free plan:** Register for an API key to use the published monthly service allowances.
- **Attribution:** Keyless and Free-plan access require attribution. See the [pricing page](https://www.ip2location.io/pricing) for the applicable conditions.
- **Paid plans:** Consult the [pricing page](https://www.ip2location.io/pricing) for higher quotas and additional response fields.

For authentication and rate-limiting details, see the [IP Geolocation API documentation](https://www.ip2location.io/ip2location-documentation).

## Requirements

- **Lua 5.3 or later**, as specified by the [SDK rockspec](https://github.com/ip2location/ip2location-io-lua/blob/main/ip2locationio-1.1.0-1.rockspec).
- [LuaRocks](https://luarocks.org/) to install the SDK and Lua dependencies.
- A native **libidn development library** for the documented installation procedure (on Debian/Ubuntu, `libidn-dev`).
- LuaRocks dependencies declared by the SDK: `lua-nums`, `json-lua`, `luasocket`, `urlencode`, `idna` and `net-url`.
- An [IP2Location.io API key](https://www.ip2location.io/pricing) for SDK lookups.
- Network connectivity to the IP2Location.io services.

> **Important:** The upstream installation instructions explicitly install `lua-nums` from the LuaRocks development server before installing `ip2locationio`. Follow that procedure rather than assuming that only `luarocks install ip2locationio` is sufficient on every system.

## Installation

### 1. Install the native dependency and Lua packages

The [official Lua quickstart](https://ip2location-io-lua.readthedocs.io/en/latest/quickstart.html) provides the following commands for Debian/Ubuntu-like systems:

```bash
sudo apt update
sudo apt install -y libidn-dev
luarocks install --server=https://luarocks.org/dev lua-nums
luarocks install ip2locationio
```

Install Lua 5.3+ and LuaRocks first if they are not already present. On other operating systems, install the equivalent native `libidn` headers and use the available LuaRocks installation method. The rockspec declares the remaining Lua dependencies, which LuaRocks normally resolves during installation.

### 2. Set your API key

Avoid putting API keys directly into source files. Configure an environment variable instead.

**Linux / macOS:**

```bash
export IP2LOCATION_API_KEY='YOUR_API_KEY'
```

**Windows Command Prompt:**

```bat
set IP2LOCATION_API_KEY=YOUR_API_KEY
```

The Lua examples read this variable using `os.getenv()` and assign it to `configuration.api_key`.

## Quickstart: IP geolocation lookup

Create a file named `lookup.lua`:

```lua
local configuration = require("configuration")
local ipgeolocation = require("ipgeolocation")

local api_key = os.getenv("IP2LOCATION_API_KEY")
if not api_key or api_key == "" then
    io.stderr:write("Set the IP2LOCATION_API_KEY environment variable.\n")
    os.exit(1)
end

configuration.api_key = api_key
local geo = ipgeolocation:open(configuration)

local result = geo:lookup("8.8.8.8")

print("Country: " .. tostring(result.country_name or "N/A"))
print("City: " .. tostring(result.city_name or "N/A"))
print("ISP: " .. tostring(result.isp or "N/A"))
```

Run it:

```bash
lua lookup.lua
```

The official SDK flow is `require()` → set `configuration.api_key` → `ipgeolocation:open(configuration)` → `geo:lookup(ip)`. This example additionally uses `os.getenv()` to avoid hard-coding credentials. If the API key is missing, it writes a message to standard error and exits with status **1**.

The returned fields depend on your plan and the IP address. See the [official geolocation example](https://ip2location-io-lua.readthedocs.io/en/latest/quickstart.html#lookup-ip-address-geolocation-data) for the extended response fields.

## More usage examples

Each snippet below assumes you have already run:

```lua
local configuration = require("configuration")
local api_key = os.getenv("IP2LOCATION_API_KEY")
assert(api_key and api_key ~= "", "Set IP2LOCATION_API_KEY")
configuration.api_key = api_key
```

These are concise adaptations of the [official Lua examples](https://ip2location-io-lua.readthedocs.io/en/latest/quickstart.html), with nil checks where fields are optional.

### Request translated location names

Pass a language code as the optional second argument to `:lookup(ip, lang)`. Translated names are available on **Plus and Security** plans.

```lua
local ipgeolocation = require("ipgeolocation")
local geo = ipgeolocation:open(configuration)
local result = geo:lookup("8.8.8.8", "fr")

print("Country: " .. tostring(result.country_name or "N/A"))
if result.country and result.country.translation then
    print("Translated country: " .. tostring(result.country.translation.value or "N/A"))
end
```

### Inspect available proxy indicators

Proxy and threat-related values depend on your plan and the address queried. Check for a nested `proxy` table before reading its fields.

```lua
local ipgeolocation = require("ipgeolocation")
local geo = ipgeolocation:open(configuration)
local result = geo:lookup("8.8.8.8")

print("Is proxy: " .. tostring(result.is_proxy))
if result.proxy then
    print("VPN: " .. tostring(result.proxy.is_vpn))
    print("Tor: " .. tostring(result.proxy.is_tor))
    print("Data center: " .. tostring(result.proxy.is_data_center))
else
    print("Detailed proxy data is unavailable in this response.")
end
```

### Inspect ASN and network information

The main geolocation result may contain `asn`, `as` and `isp`. On eligible plans, the nested `as_info` structure provides additional AS details.

```lua
local ipgeolocation = require("ipgeolocation")
local geo = ipgeolocation:open(configuration)
local result = geo:lookup("8.8.8.8")

print("ASN: " .. tostring(result.asn or "N/A"))
print("AS: " .. tostring(result.as or "N/A"))
print("ISP: " .. tostring(result.isp or "N/A"))

if result.as_info then
    print("AS name: " .. tostring(result.as_info.as_name or "N/A"))
    print("AS number: " .. tostring(result.as_info.as_number or "N/A"))
end
```

### Look up domain WHOIS information

Initialize the WHOIS module and call `:lookup(domain)`. Registration details can be missing or redacted.

```lua
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)
local result = whois:lookup("example.com")

print("Domain: " .. tostring(result.domain or "N/A"))
print("Created: " .. tostring(result.create_date or "N/A"))
print("Expires: " .. tostring(result.expire_date or "N/A"))
print("Registrar: " .. tostring(result.registrar and result.registrar.name or "N/A"))

if type(result.nameservers) == "table" then
    print("Nameservers: " .. table.concat(result.nameservers, ", "))
end
```

The [official WHOIS example](https://ip2location-io-lua.readthedocs.io/en/latest/quickstart.html#lookup-domain-information) also covers registrar, registrant, admin, technical and billing contact fields.

### Use domain and Punycode utilities

The Lua SDK exposes lowercase helper method names (different from the method casing used in some other language SDKs):

```lua
local domainwhois = require("domainwhois")
local whois = domainwhois:open(configuration)

print(whois:getpunycode("täst.de"))
print(whois:getnormaltext("xn--tst-qla.de"))
print(whois:getdomainname("https://www.example.com/path"))
print(whois:getdomainextension("example.com"))
```

These helpers do not require a remote WHOIS query. Internationalized-domain conversions depend on the SDK's IDN-related dependencies and valid input.

### Find domains hosted on an IP address

Use `hosteddomain:open(configuration)` and `:lookup(ip, page)`. The page argument is optional.

```lua
local hosteddomain = require("hosteddomain")
local hosted = hosteddomain:open(configuration)
local result = hosted:lookup("8.8.8.8")

print("Total domains: " .. tostring(result.total_domains or "N/A"))
print("Page: " .. tostring(result.page or "N/A"))
print("Total pages: " .. tostring(result.total_pages or "N/A"))

if type(result.domains) == "table" then
    print("Domains: " .. table.concat(result.domains, ", "))
end
```

For another page, call `hosted:lookup("8.8.8.8", 2)` when the response indicates more pages. The response includes pagination fields such as `page`, `per_page`, `total_pages` and `domains`.

## Lua setup and troubleshooting

- **`module 'configuration' not found`:** Verify `luarocks install ip2locationio` succeeded and that `lua` and `luarocks` target compatible Lua versions and module paths. Check `luarocks path` for the environment configuration.
- **Missing `lua-nums` or IDN-related dependencies:** Retry the documented development-server install for `lua-nums` and ensure the native `libidn` development library is available.
- **HTTP or HTTPS request errors:** Check network connectivity and your LuaSocket/TLS environment. The SDK implementation uses `socket.http` for requests to HTTPS API URLs; support for HTTPS is not guaranteed by a basic LuaSocket installation. If requests fail at the transport layer, review the SDK's HTTP implementation and TLS setup rather than assuming an API-key problem.
- **API lookup errors:** Confirm that `IP2LOCATION_API_KEY` is set, the key has access to the requested service and its quota has not been exhausted.
- **Missing response fields:** Some nested tables and optional attributes are plan-dependent. Test for `nil` before accessing them.

## Common use cases

- **Website or application localization:** Suggest regional content, language or currency using approximate IP geolocation.
- **Traffic analytics:** Enrich Lua application and server logs with country, location and network attributes.
- **Security review:** Use available proxy, VPN, Tor, crawler and fraud signals as supporting evidence in broader risk assessments, not as the sole basis for decisions.
- **Domain research:** Review WHOIS registration dates, registrar details, nameservers and available contact data.
- **Network and hosting research:** Examine ASNs, ISPs and domain names hosted on IP addresses.

## Documentation and support

- [Lua SDK installation and sample code](https://ip2location-io-lua.readthedocs.io/en/latest/quickstart.html)
- [Lua SDK source repository](https://github.com/ip2location/ip2location-io-lua)
- [Lua SDK rockspec and dependency declarations](https://github.com/ip2location/ip2location-io-lua/blob/main/ip2locationio-1.1.0-1.rockspec)
- [IP2Location.io API plans and query limits](https://www.ip2location.io/pricing)
- [IP Geolocation API documentation](https://www.ip2location.io/ip2location-documentation)
- [Report a Lua SDK issue or request a feature](https://github.com/ip2location/ip2location-io-lua/issues)
- [API and account support](https://www.ip2location.io/contact-us)

## License

Licensed under the **MIT License**. See [LICENSE](./LICENSE).

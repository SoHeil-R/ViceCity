resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'vMenu'
description 'Server sided trainer for FiveM with custom permissions, using a custom MenuAPI.'
author 'Tom Grobbe (www.vespura.com)'
version 'v3.1.0'
url 'https://github.com/TomGrobbe/vMenu/'
client_debug_mode 'false'
server_debug_mode 'false'
experimental_features_enabled '0' -- leave this set to '0' to prevent compatibility issues and to keep the save files your users.

files {
    'Newtonsoft.Json.dll',
    'MenuAPI.dll',
    'config/locations.json',
    'config/addons.json',
}

client_script 'vMenuClient.net.dll'
server_script 'vMenuServer.net.dll'

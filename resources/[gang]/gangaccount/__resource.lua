resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Gang Account'

version '1.0.1'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/classes/addonaccount.lua',
	'server/main.lua'
}

dependency 'essentialmode'
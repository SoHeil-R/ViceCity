resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'CryptoCustoms'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}

dependency 'essentialmode'

export 'GeneratePlate'
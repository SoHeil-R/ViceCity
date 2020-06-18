resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Advanced Garage'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'server/WantedVehicle.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'essentialmode',
	'esx_vehicleshop',
	'esx_property'
}

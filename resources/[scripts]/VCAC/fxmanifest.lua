fx_version 'adamant'
games {'gta5'}

client_scripts {
	'configs/clientconfig.lua',
	'client.lua'
}


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'configs/*.lua',
	'tables/*.lua',
	'server.lua'
}



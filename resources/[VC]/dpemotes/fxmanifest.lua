fx_version 'adamant'

game 'gta5'

client_scripts {
	'@NativeUI/NativeUI.lua',
	'Config.lua',
	'Client/*.lua'
}

server_scripts {
	'Config.lua',
	'@mysql-async/lib/MySQL.lua',
	'Server/*.lua'
}

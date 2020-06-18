fx_version 'adamant'
games {'gta5'}

client_script 'client.lua'


server_scripts {
	'configs/*.lua',
	'tables/*.lua',
	'server.lua'
}

-- extra data can be used as well
my_data 'one' { two = 42 }
my_data 'three' { four = 69 }

-- due to Lua syntax, the following works too:
my_data('nine')({ninety = "nein"})

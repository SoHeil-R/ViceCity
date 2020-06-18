

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
	"@essentialmode/locale.lua",
    "client.lua",
}

server_scripts {
	"server.lua",
	'@essentialmode/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}
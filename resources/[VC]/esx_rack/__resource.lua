resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

description 'ESX Unrack/Rack script developed by STR0UDY'

server_scripts {
	'@essentialmode/locale.lua',
	'server.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'client/main.lua'
}


dependencies {
	'essentialmode'
}

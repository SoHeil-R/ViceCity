resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX CustomItems'

version '1.0.0'

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

dependencies {
	'essentialmode'
}

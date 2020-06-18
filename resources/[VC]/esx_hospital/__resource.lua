resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Hospital'

version '1.0.0'

server_scripts {
  '@essentialmode/locale.lua',
  'locales/en.lua',
  'config.lua',
  'server/main.lua'
}

client_scripts {
  '@essentialmode/locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/main.lua'
}

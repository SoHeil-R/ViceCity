resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_script {
"client/main.lua"
}

server_script {
"server/main.lua",
'@async/async.lua',
'@mysql-async/lib/MySQL.lua',
}
fx_version 'bodacious'

game 'gta5'

server_scripts { 
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'locale.lua',
	'locales/fr.lua',
	'locales/en.lua',

	'config.lua',
	'config.weapons.lua',

	'server/util.lua',
	'server/common.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/db.lua',
	'server/classes/player.lua',
	'server/classes/groups.lua',
	'server/player/login.lua',
	'server/commands.lua',

	'shared/modules/math.lua',
	'shared/functions.lua'
}

client_scripts {
	'locale.lua',
	'locales/fr.lua',
	'locales/en.lua',

	'config.lua',
	'config.weapons.lua',

	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',

	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',

	'shared/modules/math.lua',
	'shared/functions.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'locale.js',
	'html/ui.html',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/wrapper.js',
	'html/js/app.js',

	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',

	'html/img/accounts/bank.png',
	'html/img/accounts/black_money.png'
}

exports {
	'getUser'
}

server_exports {
	'addAdminCommand',
	'addCommand',
	'addGroupCommand',
	'addACECommand',
	'canGroupTarget',
	'log',
	'debugMsg',
	'GetPlayerICName'
}


fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'vames™️#1400'
description 'vms_identity'
version '1.0.6'
shared_script {
	'@es_extended/imports.lua',
	'config/config.lua',
}
client_scripts {
	"client/main.lua"
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}
ui_page 'html/index.html'
files {
	'html/index.html',
	'html/js/script.js',
	'html/css/style.css',
	'config/translation.js'
}
escrow_ignore {
	'config/*.lua',
	'client/*.lua',
	'server/*.lua',
}
dependency '/assetpacks'
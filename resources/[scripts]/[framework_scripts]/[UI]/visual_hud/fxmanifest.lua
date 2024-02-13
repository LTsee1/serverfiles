fx_version 'cerulean'

game 'gta5'

lua54 'on'

description 'Koja Hud'

version '1.0'


client_scripts {
	'client/radiolist.lua',
	'client/main.lua',
	'client/seatbelt.lua',
	'client/engine.lua',
	"radiolist/module/**/client.lua",
    "radiolist/client/*.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	"radiolist/module/**/server.lua",
    "radiolist/server/*.lua"
}

shared_script {
	'@ox_lib/init.lua',
	"radiolist/shared/*.lua"
}
exports {
	"notify",
}

files {
	'assets/ui.html',
	'assets/fonts/*.ttf',
	'assets/fonts/*.otf',
	'assets/css/*.css',
	'assets/images/*.jpg',
	'assets/images/*.png',
	'assets/js/*.js'
}


ui_page "assets/ui.html"


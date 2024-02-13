fx_version 'cerulean'
game 'gta5'
lua54 'yes'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/server.lua',
}

client_scripts {
	'config.lua',
	'client/utils.lua',
	'client/client.lua'
}

files {
    'html/index.html',
	'html/script.js',
	'html/carousel.css',
	'html/design.css',
	'html/jquery-ui.js',
	'html/jqueri-ui.css',
	'html/nano.min.css',
    'imgs/*.png',
	'imgs/brands/*.png',
}

ui_page 'html/index.html'

shared_script '@es_extended/imports.lua'
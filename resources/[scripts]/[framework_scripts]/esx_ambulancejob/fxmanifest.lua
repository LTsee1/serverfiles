fx_version "bodacious"

games {"gta5"}
lua54 'yes'


shared_script '@es_extended/imports.lua'
shared_script '@ox_lib/init.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	"config.lua",
	"locales/en.lua",
	 "client/main.lua" 
}

exports {
	'isDead',
	'IsBlockWeapon'
}

dependency 'es_extended'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/male.png',
	'html/duze.png',
}

--[[

  ESX RP Chat

--]]

fx_version "bodacious"

games {"gta5"}
lua54 'yes'

shared_script '@es_extended/imports.lua'

client_scripts {
	'config.lua',
	'client/main.lua'
}

server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'

}

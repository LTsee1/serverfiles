fx_version 'cerulean'

games { "gta5" }

lua54 'on'

author 'CikanaModding'

description "Fleecabank-rework bought from CikanaModding's tebex"

version "1.0.0"

server_scripts {
	'stream/version/server.lua'
}

client_scripts {
	'stream/version/client.lua'
}


escrow_ignore{
    'stream/**/*.ytd',
}

this_is_a_map "yes"


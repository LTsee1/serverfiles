fx_version 'cerulean'
game "gta5"
lua54 'yes'

shared_script '@ox_lib/init.lua'

client_scripts {
    'exports/*.lua',
    'smallresources/*.lua',
}

server_scripts {
    'server/*.lua'
}
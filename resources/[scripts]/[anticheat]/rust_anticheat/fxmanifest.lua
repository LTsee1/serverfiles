fx_version 'cerulean'
games { 'gta5' }

description 'Rust Anticheat :)'
Author 'Tsee'
version '1.0.0'


client_scripts {
    '@menuv/menuv.lua',
    'client.lua',
    'admin_menu.lua',
    'c_tokenizer.lua'
}



server_scripts {
    's_rust.lua',
    's_config.lua',
    'server.lua',
}

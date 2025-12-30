fx_version 'cerulean'
game 'gta5'

author 'DonaldWeed'
description 'ESX Head ID & Identity System'
version '1.2.0'

shared_scripts {
    '@es_extended/imports.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}


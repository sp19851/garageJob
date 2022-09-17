fx_version 'cerulean'
game 'gta5'

descrioptions 'JobGarages fo QBCore by Cruso#5044'
version '0.0.0'

shared_scripts {
    'config.lua',
	
}

client_script {'@PolyZone/client.lua',
               '@PolyZone/BoxZone.lua',
               '@PolyZone/ComboZone.lua',
               'client.lua'}

server_script {	'@oxmysql/lib/MySQL.lua',
                'server.lua'
}
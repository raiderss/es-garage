fx_version "adamant"

description "EyesStore"
author "Raider#0101"
version '1.0.0'
repository 'https://discord.com/invite/EkwWvFS'

game "gta5"

client_script { 
"client/*.lua"
}

server_script {
"@mysql-async/lib/MySQL.lua",
"server/*.lua"
}

shared_script {
"config.lua"
}


ui_page "index.html"

files {
    'index.html',
    'vue.js',
    'assets/**/*.*',
    'assets/font/*.otf', 
}

lua54 'yes'
-- dependency '/assetpacks'

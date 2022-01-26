fx_version 'bodacious'
games { 'gta5' }

description "Tunneling between client and server"
author "brefabu"
url "https://brefabu.ro"
version "1.0"

server_scripts{
    "packages/server.lua"
}

client_scripts{ 
    "packages/client.lua"
}

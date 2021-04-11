#!/bin/sh  
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH  
export SteamAppID=892970

# Set default value for env vars
[ -z $SERVER_NAME ] && export SERVER_NAME=myserver
[ -z $SERVER_PORT ] && export SERVER_PORT=2456
[ -z $W0RLD_NAME ] && export W0RLD_NAME=myworld
[ -z $SERVER_PASSWORD ] && export SERVER_PASSWORD=mypass

echo "Starting server"  
../valheim/valheim_server.x86_64 -name $SERVER_NAME -port $SERVER_PORT -nographics -world $W0RLD_NAME -password $SERVER_PASSWORD -public 1
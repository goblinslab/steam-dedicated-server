#!/bin/bash

# Check if world files are already init
[ -d /app/conan-exiles/ConanSandbox/Saved/Config ] || mv /app/conan-exiles/ConanSandbox/Init /app/conan-exiles/ConanSandbox/Saved

# Setup config files
engineIniPath='/app/conan-exiles/ConanSandbox/Saved/Config/WindowsServer/Engine.ini'
gameIniPath='/app/conan-exiles/ConanSandbox/Saved/Config/WindowsServer/Game.ini'
serverSettingsIniPath='/app/conan-exiles/ConanSandbox/Saved/Config/WindowsServer/ServerSettings.ini'

# Default value
[ -z $PORT ] && export PORT=7777
[ -z $SERVERQUERYPORT ] && export SERVERQUERYPORT=27015
[ -z $SERVERNAME ] && export SERVERNAME=defaultServerName
[ -z $SERVERPASSWORD ] && export SERVERPASSWORD=password

[ -z $RCONENABLED ] && export RCONENABLED=1
[ -z $RCONPASSWORD ] && export RCONPASSWORD=rconpassword
[ -z $RCONPORT ] && export RCONPORT=25575

[ -z $ADMINPASSWORD ] && export ADMINPASSWORD=adminpassword

cat >> $engineIniPath <<EOF
[URL]
Port = ${PORT}
ServerQueryPort = ${SERVERQUERYPORT}
ServerName = ${SERVERNAME}
ServerPassword = ${SERVERPASSWORD}

[RconPlugin]
RconEnabled = ${RCONENABLED}
RconPassword = ${RCONPASSWORD}
RconPort = ${RCONPORT}
RconMaxKarma= 60
EOF

cat >> $serverSettingsIniPath <<EOF
AdminPassword = ${ADMINPASSWORD}
EOF

# Run the Conan server
xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine64 ConanSandboxServer.exe -log
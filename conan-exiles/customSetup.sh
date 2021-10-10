#!/bin/bash

# Run the server one time to init the server
timeout 300 xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine64 ConanSandboxServer.exe -log

# Backup usefull files
mv /app/conan-exiles/ConanSandbox/Saved/ /app/conan-exiles/ConanSandbox/Init/ 

echo "init done!"
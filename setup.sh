#!/bin/bash

echo "Initializing Minecraft Server Deployment..."

INSTALL_DIR="$HOME/dockerCraft"

# --- Cloning Repository ---

if [ ! -d "$INSTALL_DIR" ]; then

	echo "Downloading Server Infrastructure..."
	git clone https://github.com/IanYarull/minecraftServerDocker.git "$INSTALL_DIR"
else

	echo "Infrastructure folder already exists. Updating..."
	cd "$INSTALL_DIR" && git pull origin main

fi


# --- Creating Folders for Data ---

cd "$INSTALL_DIR" || exit

echo "Creating data directories..."

mkdir -p minecraft_server/data/{world,logs,config,mods}

mkdir minecraftBackups 

# --- Extracting Defaults ---

echo "Loading server configurations from defaults..."

cp -n minecraft_server/defaultconfigs/*.json minecraft_server/
cp -n minecraft_server/defaultconfigs/server.properties minecraft_server/
cp -n minecraft_server/defaultconfigs/modpack-url.txt minecraft_server/


# --- Interactive URL Setup ---

echo "Checking Modpack URL..."

# Check if the active file doesn't exist OR is completely empty

EXISTING_URL=$(grep -v '^#' minecraft_server/modpack-url.txt | grep -v '^$')

if [ -z "$EXISTING_URL" ]; then

	echo "No active Modpack URL found."
	read -p "Enter your packwiz pack.toml URL (or press Enter to configure manually later): " USER_URL

	#Appending new URL to txt file

	if [ -n "$USER_URL" ]; then
	echo "$USER_URL" >> minecraft_server/modpack-url.txt
        echo "URL saved!"
    fi


else
    echo "Modpack URL already configured."
fi


# --- Server Icon and Permissions ---

echo "Setting up server icon..."

if [ -f minecraft_server/defaultconfigs/server-icon.png ]; then
    cp -n minecraft_server/defaultconfigs/server-icon.png minecraft_server/data/server-icon.png
fi

chmod +x minecraft_server/run.sh

echo "All good! You can now run:"
echo "cd $INSTALL_DIR && docker compose up -d"
echo "To start your server!"

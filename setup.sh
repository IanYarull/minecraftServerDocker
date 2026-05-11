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

mkdir -p minecraftServer/data/{world,logs,config,mods}

mkdir minecraftBackups 

# --- Extracting Defaults ---

echo "Loading server configurations from defaults..."

cp -n minecraftServer/defaultConfigs/*.json minecraftServer/
cp -n minecraftServer/defaultConfigs/server.properties minecraftServer/
cp -n minecraftServer/defaultConfigs/modpack-url.txt minecraftServer/


# --- Interactive URL Setup ---

echo "Checking Modpack URL..."

# Check if the active file doesn't exist OR is completely empty

EXISTING_URL=$(grep -v '^#' minecraftServer/modpack-url.txt | grep -v '^$')

if [ -z "$EXISTING_URL" ]; then

	echo "No active Modpack URL found."
	read -p "Enter your packwiz pack.toml URL (or press Enter to configure manually later), include https header: " USER_URL

	#Appending new URL to txt file

	if [ -n "$USER_URL" ]; then
	echo "$USER_URL" >> minecraftServer/modpack-url.txt
        echo "URL saved!"
    fi


else
    echo "Modpack URL already configured."
fi


# --- Server Icon and Permissions ---

echo "Setting up server icon..."

if [ -f minecraftServer/defaultConfigs/server-icon.png ]; then
    cp -n minecraftServer/defaultConfigs/server-icon.png minecraftServer/
fi

chmod +x minecraftServer/entrypoint.sh

echo "All good! You can now run:"
echo "cd $INSTALL_DIR && docker compose up -d"
echo "To start your server!"

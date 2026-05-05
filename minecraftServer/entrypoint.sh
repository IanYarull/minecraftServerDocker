#!/usr/bin/env sh

# --- Library Installation ---

if [ ! -d "libraries" ]; then

	echo "Libraries folder missing! Downloading NeoForge installer..."

    	# Replace this URL with the exact installer link for your version of NeoForge, if you want to change it of course
	wget -O neoforge-installer.jar "https://maven.neoforged.net/releases/net/neoforged/neoforge/21.1.228/neoforge-21.1.228-installer.jar"

	echo "Running NeoForge installation..."
	java -jar neoforge-installer.jar --installServer

	echo "Cleaning up installer files..."
	rm neoforge-installer.jar
	rm run.sh run.bat
	# Delete the generic scripts Forge makes so they don't clutter your folder

fi

# --- Get Modpack ---

MODPACK_URL=$(grep -v '^#' modpack-url.txt | grep -v '^$' | tr -d '\r' | head -n 1)

if [ -z "$MODPACK_URL" ]; then
    echo "ERROR: modpack-url.txt is empty!"
    echo "Please edit minecraft_server/modpack-url.txt to include your packwiz pack.toml URL."
    echo "Server startup aborted."
    exit 1
fi

cd /minecraft

echo "Running packwiz on: $MODPACK_URL"
java -jar packwiz-installer-bootstrap.jar -g -s server $MODPACK_URL

java @user_jvm_args.txt @libraries/net/neoforged/neoforge/21.1.228/unix_args.txt "$@"

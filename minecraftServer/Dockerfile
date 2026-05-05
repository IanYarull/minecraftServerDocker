FROM eclipse-temurin:21-jre-jammy

WORKDIR /minecraft

COPY entrypoint.sh /minecraft/entrypoint.sh

# Fix line endings and make the script executable in one layer

RUN sed -i 's/\r$//' /minecraft/entrypoint.sh && \
	chmod +x /minecraft/entrypoint.sh

# Download the Packwiz Bootstrap via wget

RUN apt-get update && apt-get install -y wget && \
	wget -O /minecraft/packwiz-installer-bootstrap.jar https://github.com/packwiz/packwiz-installer-bootstrap/releases/latest/download/packwiz-installer-bootstrap.jar && \
	rm -rf /var/lib/apt/lists/*

# Pre-accept EULA

RUN echo "eula=true" > eula.txt

# Prevent Java UI errors

ENV JAVA_TOOL_OPTIONS="-Djava.awt.headless=true"

EXPOSE 25565

CMD ["./entrypoint.sh", "nogui"]

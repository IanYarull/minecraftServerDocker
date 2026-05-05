#!/bin/sh
set -e

echo "Checking for wg0.conf..."
ls -l /etc/wireguard/wg0.conf

echo "Starting WireGuard..."
# Using --foreground can help some containers stay attached, 
# but wg-quick up is standard.
wg-quick up wg0

echo "Diagnostic: Interface Status"
ip a show wg0

echo "Diagnostic: WireGuard Status"
wg show

# Catch signals for clean shutdown
trap "wg-quick down wg0; exit" SIGINT SIGTERM

echo "VPN is officially active. Entering wait state..."
sleep infinity

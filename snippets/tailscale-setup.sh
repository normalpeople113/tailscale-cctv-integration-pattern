
#!/bin/bash
# Pattern: Tailscale Client Setup (Ubuntu/Debian & OpenWrt)
# Usage: sudo bash tailscale-setup.sh <auth-key>
# Note: Replace <auth-key> dengan key dari Tailscale Admin Console

set -e

AUTH_KEY="${1:?Error: Tailscale auth key required. Usage: $0 <auth-key>}"

echo "[1/3] Installing Tailscale..."
if command -v apt-get &>/dev/null; then
    curl -fsSL https://tailscale.com/install.sh | sh
elif command -v opkg &>/dev/null; then
    # OpenWrt / GL.iNet
    opkg update && opkg install tailscale
fi

echo "[2/3] Starting & authenticating..."
tailscale up --authkey="$AUTH_KEY" --advertise-routes=192.168.1.0/24 --accept-routes

echo "[3/3] Verifying connection..."
tailscale status
echo "Setup complete. Tailscale IP: $(tailscale ip -4)"

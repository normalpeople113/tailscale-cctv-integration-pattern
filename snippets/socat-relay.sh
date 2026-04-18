
#!/bin/bash
# Pattern: Relay local RTSP stream to Tailscale IP for remote access
# Usage: ./socat-relay.sh <cctv-local-ip> <cctv-rtsp-port> <tailscale-port>

CCTV_IP="${1:-192.168.1.100}"
CCTV_PORT="${2:-554}"
TS_PORT="${3:-1554}"

# Forward: Tailscale:1554 → Local CCTV:554/rtsp
socat TCP-LISTEN:$TS_PORT,reuseaddr,fork TCP:$CCTV_IP:$CCTV_PORT &
echo "Relay active: tailscale-ip:$TS_PORT → $CCTV_IP:$CCTV_PORT"

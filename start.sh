#!/bin/bash
# Exit on error
set -e

# Check required environment variables
if [ -z "$CLOUDFLARE_TUNNEL_TOKEN" ]; then
  echo "Error: CLOUDFLARE_TUNNEL_TOKEN is not set!"
  exit 1
fi

# Optional: Node auth key check
if [ -z "$TUNNEL_AUTH_KEY" ]; then
  echo "Warning: TUNNEL_AUTH_KEY is not set, starting Node service without auth"
fi

# Start Node service in the background
if [ -z "$TUNNEL_AUTH_KEY" ]; then
  tunnel-node &
else
  tunnel-node --auth-key "$TUNNEL_AUTH_KEY" &
fi

# Start Cloudflare tunnel in the foreground
/home/tunnel/cloudflared tunnel \
  --edge-ip-version auto \
  --no-autoupdate \
  --protocol http2 \
  run --token "$CLOUDFLARE_TUNNEL_TOKEN"

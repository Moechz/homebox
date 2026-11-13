#!/bin/sh
# TOS wrapper: Homebox requires a >=32-byte API key pepper at startup.
# Generate it once, keep it in /data, and reuse it so existing API keys stay
# valid across restarts and updates.
set -u
set -e
mkdir -p /data
F=/data/api_key_pepper
if [ ! -s "$F" ]; then
  head -c 48 /dev/urandom | base64 | tr -d '\n' > "$F"
fi
export HBOX_AUTH_API_KEY_PEPPER="$(cat "$F")"
exec /app/api /data/config.yml

#!/usr/bin/env bash

# Find local IP address on macOS
IP=$(ipconfig getifaddr en0 2>/dev/null)
if [ -z "$IP" ]; then
  IP=$(ipconfig getifaddr en1 2>/dev/null)
fi
if [ -z "$IP" ]; then
  IP="localhost"
fi

PORT=8080

echo "======================================================="
echo "   STEVE'S DIAMOND CATCH - MOBILE GAME SERVER"
echo "======================================================="
echo ""
echo " 1. Make sure your smartphone is connected to the same Wi-Fi."
echo " 2. On your iPhone (Safari) or Android (Chrome), open:"
echo ""
echo "    👉   http://${IP}:${PORT}   👈"
echo ""
echo " 3. Tap 'Share' -> 'Add to Home Screen' (iOS) or"
echo "    'Install App' (Android) for full-screen arcade mode!"
echo ""
echo " Press Ctrl+C in this terminal to stop the server."
echo "======================================================="
echo ""

# Start built-in HTTP server
python3 -m http.server ${PORT}

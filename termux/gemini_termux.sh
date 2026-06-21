#!/data/data/com.termux/files/usr/bin/bash
# Example Termux script to call Google Gemini (placeholder endpoint and key).
# Usage in Termux:
# 1. Save this file as termux/gemini_termux.sh
# 2. chmod +x termux/gemini_termux.sh
# 3. export GEMINI_API_KEY="your_api_key"
# 4. ./termux/gemini_termux.sh 'Hello from Termux'

API_ENDPOINT="https://api.gemini.example/v1/generate" # replace with real Gemini endpoint
API_KEY="${GEMINI_API_KEY:-YOUR_API_KEY_HERE}"

PROMPT="$1"
if [ -z "$PROMPT" ]; then
  PROMPT="Hello Gemini"
fi

if [ "$API_KEY" = "YOUR_API_KEY_HERE" ]; then
  echo "Warning: no API key set. Export GEMINI_API_KEY or edit the script to add your key."
fi

curl -s -X POST "$API_ENDPOINT" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"prompt\": \"${PROMPT}\", \"max_tokens\": 256}" \
  | jq '.'

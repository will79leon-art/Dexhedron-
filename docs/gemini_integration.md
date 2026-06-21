# Gemini integration for this repository

This document explains how to interact with Google Gemini from Termux and how to adapt the examples to other Google apps and projects.

## Prerequisites
- Termux installed on your Android device
- jq (json processor) installed in Termux: `pkg install jq`
- A valid Gemini/LLM API endpoint and API key

## Using the example Termux script
1. Put `termux/gemini_termux.sh` in the `termux/` directory and make it executable:

   chmod +x termux/gemini_termux.sh

2. Export your API key in Termux:

   export GEMINI_API_KEY="<your_api_key_here>"

3. Run the script with a prompt:

   ./termux/gemini_termux.sh "Summarize today's commits"

The script sends a minimal request to the configured endpoint. Replace `API_ENDPOINT` in the script with the real Gemini API URL and adjust request payload/headers as needed.

## Integrating with Google Apps
- For Gmail/Drive/Calendar automation, use the Google APIs with OAuth2. Do not store OAuth tokens in plaintext.
- Use server-side services (Cloud Run, Cloud Functions) or a secure mobile storage (Android keystore) for long-lived keys.

## Security
- Never commit real API keys or OAuth secrets to the repository.
- Use environment variables or a secrets manager.

## Porting to other projects
- Copy `termux/gemini_termux.sh` and update the API endpoint and request schema.
- Add language-specific SDK calls where appropriate (Python, Node.js, etc.).

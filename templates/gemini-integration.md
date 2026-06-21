# Gemini integration template

Use this template when adding Gemini-related functionality to other repositories.

## What this adds
- Termux script to call Gemini
- Documentation on setup and security
- Example request payload and instructions

## Files to include
- termux/gemini_termux.sh
- docs/gemini_integration.md
- backtrace.yml (optional)

## How to adapt
1. Add your API endpoint and key handling
2. Replace the placeholder payload with your app's prompts and post-processing
3. Add SDK dependencies if using Python/Node/etc.

## Security checklist
- Do not commit secrets
- Use environment variables or secret managers
- Review OAuth scopes and token storage

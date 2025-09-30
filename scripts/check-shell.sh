#!/usr/bin/env bash
# Super simple config checker

echo "Checking shell configuration..."

# Check critical files exist
for file in ~/.zshenv ~/.zshrc; do
    if [[ ! -e "$file" ]]; then
        echo "ERROR: $file missing!"
        exit 1
    fi
done

# Check environment variables
source ~/.zshenv 2>/dev/null
if [[ -z "$STARSHIP_THEME" ]]; then
    echo "WARNING: STARSHIP_THEME not set"
fi

# Check PATH has important stuff
if ! command -v nvm &>/dev/null && [[ -d "$HOME/.nvm" ]]; then
    echo "WARNING: NVM not in PATH"
fi

echo "Basic checks passed!"
# Shell Configuration Migration - Practical Fix

## Quick Summary
Your shell config broke because `.zshenv` didn't get symlinked properly. Here's how to fix it and prevent it happening again.

## The Actual Problems
1. Missing `.zshenv` symlink → environment variables not loading
2. Symlink script uses `$(pwd)` → breaks when run from wrong directory
3. `custom.zsh` expects `$STARSHIP_THEME` → crashes when undefined
4. Missing shell options → no auto-cd, limited history

## Simple Fixes

### 1. Fix the Symlinks (One Time)
```bash
# Just create the missing symlinks manually
ln -sf ~/.config/zsh/.zshenv ~/.zshenv
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
ln -sf ~/.config/zsh/.zprofile ~/.zprofile 2>/dev/null || true

# Verify they work
ls -la ~/.zsh* | grep "\->"
```

### 2. Fix the Symlink Script
Replace `$(pwd)` with the actual path in your `symlinks.sh`:

```bash
#!/usr/bin/env bash
# Fixed symlinks.sh - uses absolute paths

CONFIG_DIR="/Users/parkerrex/.config"

# Create symlinks
ln -sf "$CONFIG_DIR/zsh/.zshenv" ~/.zshenv
ln -sf "$CONFIG_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$CONFIG_DIR/zsh/.zprofile" ~/.zprofile
ln -sf "$CONFIG_DIR/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$CONFIG_DIR/git/.gitconfig" ~/.gitconfig

# Quick verification
echo "Checking symlinks:"
for file in ~/.zshenv ~/.zshrc ~/.tmux.conf ~/.gitconfig; do
    if [[ -L "$file" ]]; then
        echo "✓ $file → $(readlink $file)"
    else
        echo "✗ $file missing"
    fi
done
```

### 3. Add Safety Check to custom.zsh
```bash
# Add this to the top of custom.zsh
if [[ -n "$STARSHIP_THEME" ]]; then
    starship config palette $STARSHIP_THEME
fi
```

### 4. Add Missing Shell Options
Add to your `.zshrc`:

```bash
# Shell options that should have been there
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
```

## Quick Validation Script
Save this as `check-shell.sh` and run it after any config changes:

```bash
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
```

## Prevention (Dead Simple)

1. **Always run the symlink script from the .config directory**
   ```bash
   cd ~/.config && ./symlinks.sh
   ```

2. **Test after changes**
   ```bash
   # Open new terminal and check
   echo $STARSHIP_THEME  # Should show something
   type nvm              # Should find it
   cd ..                 # Should work without typing 'cd'
   ```

3. **Keep a backup**
   ```bash
   # Before any config changes
   cp ~/.zshrc ~/.zshrc.backup
   cp ~/.zshenv ~/.zshenv.backup
   ```

## That's It
No complex monitoring, no databases, no 500-line scripts. Just:
- Fix the broken symlinks
- Use absolute paths in the script
- Add a safety check for undefined variables
- Test that your shell works after changes

If something breaks again, just run the symlink script from the right directory and you're good.
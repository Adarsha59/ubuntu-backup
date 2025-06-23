#!/bin/bash

# Set backup destination folder
BACKUP_DIR="$HOME/Music/ubuntu-backup"

echo "Starting backup to $BACKUP_DIR"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# 1. Backup important dotfiles
echo "Backing up shell and git config files..."
cp -v ~/.zshrc ~/.bashrc ~/.profile ~/.gitconfig ~/.bash_aliases "$BACKUP_DIR" 2>/dev/null

# 2. Backup SSH keys
echo "Backing up SSH keys..."
cp -r ~/.ssh "$BACKUP_DIR" 2>/dev/null

# 3. Backup GNOME/Dconf settings
echo "Exporting GNOME settings..."
dconf dump / > "$BACKUP_DIR/gnome-settings.dconf"

# 4. Backup manual installed packages list
echo "Backing up manual apt package list..."
comm -23 <(apt-mark showmanual | sort) <(gzip -dc /var/log/installer/initial-status.gz | awk '/^Package: / { print $2 }' | sort) > "$BACKUP_DIR/manual-packages.txt"

# 5. Backup Flatpak apps list
echo "Backing up Flatpak apps list..."
flatpak list --app --columns=name > "$BACKUP_DIR/flatpak-apps.txt"

# 6. Backup Snap packages list
echo "Backing up Snap packages list..."
snap list > "$BACKUP_DIR/snap-packages.txt"

# 7. Backup VS Code extensions list (if code command exists)
if command -v code &>/dev/null; then
    echo "Backing up VS Code extensions..."
    code --list-extensions > "$BACKUP_DIR/vscode-extensions.txt"
else
    echo "VS Code not found, skipping extensions backup."
fi

# 8. Backup user crontab
echo "Backing up user crontab..."
crontab -l > "$BACKUP_DIR/user-crontab.txt" 2>/dev/null || echo "No crontab found."

# 9. Backup selective personal config folders (modify if you want to add more)
echo "Backing up selected config folders..."
mkdir -p "$BACKUP_DIR/.config"
cp -r ~/.config/Code/User "$BACKUP_DIR/.config/" 2>/dev/null

# 10. Backup fonts, themes, icons if they exist
echo "Backing up fonts, themes, and icons..."
for dir in .fonts .themes .icons; do
    if [ -d "$HOME/$dir" ]; then
        cp -r "$HOME/$dir" "$BACKUP_DIR/"
    fi
done

echo "Backup complete! All files saved in $BACKUP_DIR"

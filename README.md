# Personal Ubuntu Backup

This backup contains essential personal files and lists to help restore my Ubuntu environment.

## Backup Contents

- Shell configuration files: `.zshrc`, `.bashrc`, `.profile`, `.gitconfig`, `.bash_aliases`
- SSH keys directory: `.ssh/`
- GNOME settings dump: `gnome-settings.dconf`
- Manually installed APT packages list: `manual-packages.txt`
- Flatpak applications list: `flatpak-apps.txt`
- Snap packages list: `snap-packages.txt`
- VS Code extensions list: `vscode-extensions.txt`
- User crontab backup: `user-crontab.txt`
- Optional personal fonts, themes, and icons folders if present: `.fonts/`, `.themes/`, `.icons/`

## How to Restore

1. Copy dotfiles and SSH keys:

   ```bash
   cp .zshrc .bashrc .profile .gitconfig ~/.
   cp -r .ssh ~/
   ```

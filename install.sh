#!/bin/bash
set -e

LOCAL_PATH="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="/home/$SUDO_USER/.config"

source /etc/os-release

echo "=== Installation ==="

# Vérification des droits
if [ "$EUID" -ne 0 ]; then
  echo "Erreur : exécute ce script avec sudo."
  exit 1
fi
if [ -z "$SUDO_USER" ]; then
  echo "Erreur : lance ce script avec sudo, pas en root direct."
  exit 1
fi

# Permissions
echo "Application des permissions"
chmod -R 755 "$LOCAL_PATH"

# Supression des dépendances existantes
# echo "Supression des dépendances existantes"
# case "$ID" in
#   debian | ubuntu)
#     apt remove -y --purge rustc cargo nvim kitty
#     apt autoremove -y
#     ;;
#   fedora)
#     dnf remove -y rustc cargo nvim kitty
#     ;;
#   arch)
#     pacman -R --noconfirm rustc cargo nvim kitty
#     ;;
#   opensuse | suse)
#     zypper remove -y rustc cargo nvim kitty
#     ;;
# esac

# Supression des fichiers de configurations déjà existants
echo "Supression des fichiers de configurations déjà existants"
mkdir -p "$CONFIG_DIR"
rm -rf "$CONFIG_DIR/kitty" "$CONFIG_DIR/nvim"

# Installation des dépendances
echo "Installation des dépendances..."
case "$ID" in
  debian | ubuntu)
    apt install -y rustc cargo neovim kitty ncurses-term bat fzf
    ;;
  fedora)
    dnf install -y rustc cargo neovim kitty ncurses-term bat fzf
    ;;
  arch)
    pacman -Sy --noconfirm rustc cargo neovim kitty ncurses-term bat fzf
    ;;
  opensuse | suse)
    zypper install -y rustc cargo neovim kitty ncurses-term bat fzf
    ;;
esac
curl -sS https://starship.rs/install.sh | sh
# curl https://sh.rustup.rs -sSf | sh
# source ~/.cargo/env
if ! command -v eza >/dev/null 2>&1; then
  cargo install eza
fi
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd  
rm -r nerd-fonts

# Installation des fichiers de configurations
echo "Installation des fichiers de configurations"
[ -d /opt/shell_config/nvim ] && mv /opt/shell_config/nvim "$CONFIG_DIR"
[ -d /opt/shell_config/kitty ] && mv /opt/shell_config/kitty "$CONFIG_DIR"

# Modification du .bashrc
echo "Modification du bashrc"
grep -qxF 'eval "$(starship init bash)"' /home/$SUDO_USER/.bashrc || echo 'eval "$(starship init bash)"' >>/home/$SUDO_USER/.bashrc
grep -qxF 'alias ls="eza --icons"' /home/$SUDO_USER/.bashrc || echo 'alias ls="eza --icons"' >>/home/$SUDO_USER/.bashrc
grep -qxF 'alias ll="eza -lh --icons"' /home/$SUDO_USER/.bashrc || echo 'alias ll="eza -lh --icons"' >>/home/$SUDO_USER/.bashrc
grep -qxF 'alias la="eza -la --icons"' /home/$SUDO_USER/.bashrc || echo 'alias la="eza -la --icons"' >>/home/$SUDO_USER/.bashrc
if command -v batcat >/dev/null 2>&1; then
  grep -qxF 'alias cat="batcat"' /home/$SUDO_USER/.bashrc ||echo 'alias cat="batcat"' >> /home/$SUDO_USER/.bashrc
else
  grep -qxF 'alias cat="bat"' /home/$SUDO_USER/.bashrc ||echo 'alias cat="bat"' >> /home/$SUDO_USER/.bashrc
fi


# Verifications
fc-list | grep -i "nerd"
starship --version
eza --version
fzf --version
nvim --version
if command -v batcat >/dev/null 2>&1; then
  batcat --version
else
  bat --version
fi

echo "Installation terminée avec succès."

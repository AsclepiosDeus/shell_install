# Shell Installer

This script install a new configuration for your kitty, neovim and bash.

Make sure to save your actual configuration :

mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

And run this with sudo :

git clone git@github.com:AsclepiosDeus/shell_install.git
cd ./shell_install/
./install.sh

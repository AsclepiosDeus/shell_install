# Shell Install

Ce projet fournit une configuration complète pour **Kitty**, **Neovim** et l’environnement **Bash**, accompagnée des outils nécessaires (Starship, eza, fzf, bat, Nerd Fonts, etc.). L’objectif est d’obtenir un environnement cohérent, moderne et prêt à l’emploi sur les principales distributions Linux.

---

## Contenu

- Configuration Kitty (thèmes, options, raccourcis)
- Configuration Neovim basée sur LazyVim
- Installation et configuration de Starship
- Alias Bash (eza, bat, etc.)
- Installation automatique des dépendances selon la distribution
- Installation des Nerd Fonts

---

## Sauvegarde des configurations existantes

Avant d’installer, il est recommandé de conserver vos configurations actuelles :

```bash
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
mv ~/.config/kitty{,.bak}
```

---

## Installation

Cloner le dépôt :

```bash
git clone git@github.com:AsclepiosDeus/shell_install.git
cd shell_install
```

Lancer l’installation :

```bash
sudo ./install.sh
```

Le script détecte la distribution, installe les dépendances nécessaires, copie les configurations et met à jour le `.bashrc`.

---

## Mise à jour des sous-modules

Les thèmes Kitty sont gérés en sous-modules. Pour les mettre à jour :

```bash
git submodule update --remote --merge
```

---

## Désinstallation

Pour revenir à vos configurations précédentes :

```bash
rm -rf ~/.config/nvim
rm -rf ~/.config/kitty

mv ~/.config/nvim.bak ~/.config/nvim
mv ~/.config/kitty.bak ~/.config/kitty
```

---

## Licence

Projet distribué sous licence MIT.

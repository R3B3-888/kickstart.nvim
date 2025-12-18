# Config nvim de R3B3

## Note sur mes besoins pour l'IDE parfait

- Git staged, commit, push, pull, merge
- Git hunk : _plugin gitsigns_
- tests
- python
    - lsp pour la navigation et la doc (^K) : _pylsp_
    - autoformat et linting : _ruff_
    - pouvoir accèder aux sources dans .venv par exemple
- markdown
    - linting
    - lsp
    - autoformat
    - preview 'joli' du markdown
- terminal
    - lancer le process principal
    - console python
    - ai cli
- file explorer
    - vue sur mes fichiers
    - création de dossiers ou de fichiers facilement

**Autres besoins potentiels**

- tableurs csv etc
- latex avec preview

## Installation

### Installer Neovim

1. Dépendences : 

```bash
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl
```

2. Neovim :

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```

### Nerd font

1. [Nerd Font](https://www.nerdfonts.com/) 
2. Choisir une lib style 'Agave nerd font'

3. Déziper
```bash
unzip Agave.zip -d Agave
```

4. Le mettre dans le dossier fonts
```bash
mv Agave /usr/local/share/fonts/
```

5. Configurer la font dans les préférences du terminal

### Installer cette config

1. Supprimer la vieille config
```bash
rm -rf ~/.config/nvim/
```

2. la vrai installation
```bash
git clone git@github.com:R3B3-888/kickstart.nvim.git ~/.config/nvim
```

3. Lancer vim
```bash
nvim
```

## Docs pour apprendre vim

- [The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)
- chaînes yt ThePrimeagen et Luke Smith


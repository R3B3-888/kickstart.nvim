# kickstart.nvim

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Note sur mes besoins pour l'IDE parfait

- Git 
- Git hunk : _plugin gitsigns_
- tests
- python
    - lsp : _ruff_
    - autoformat : _ruff_
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

```bash
# Deps
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```

> [!TODO]
> Voir plus tard pour la compatibilité avec QubesOS 
> (certainement le même process avec tar.gz)

### (Optionnal) Nerd font

> [!NOTE]
> Normalement c'est mieux avec nerd font mais vas-y j'ai jamais compris comment l'installer sans que ça bug
> [Nerd Font](https://www.nerdfonts.com/) et après les .otf et .ttf dans `/usr/local/share/fonts/`
> Faire un autre truc
> l94 du init.lua `vim.g.have_nerd_font = true`

### Installer cette config

```bash
# Supprimer la vieille config
rm -rf ~/.config/nvim/

# la vrai installation
git clone git@github.com:R3B3-888/kickstart.nvim.git ~/.config/nvim
nvim
```

## Docs pour apprendre vim

- [The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)
- chaînes yt ThePrimeagen et Luke Smith

